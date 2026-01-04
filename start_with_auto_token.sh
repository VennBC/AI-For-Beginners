#!/bin/bash

# 一键启动脚本：同时启动文档服务和 Jupyter Token 服务
# 使用此脚本后，打开文档页面即可直接点击 Notebook 链接，无需手动配置 token

set -e

echo "=========================================="
echo "🚀 启动文档服务和 Jupyter Token 服务"
echo "=========================================="
echo ""

# 颜色定义
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
BLUE='\033[0;34m'
NC='\033[0m'

# 获取当前目录
PROJECT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$PROJECT_DIR"

# 检查 Python 是否安装
if ! command -v python3 &> /dev/null; then
    echo -e "${RED}❌ 错误: 未找到 python3 命令${NC}"
    echo "请先安装 Python 3"
    exit 1
fi

# 检查 Jupyter 是否运行
echo -e "${YELLOW}🔍 检查 Jupyter 服务器状态...${NC}"
JUPYTER_INFO=$(jupyter server list 2>/dev/null | grep "http://" | head -1 || echo "")

if [ -z "$JUPYTER_INFO" ]; then
    echo -e "${YELLOW}⚠️  未检测到运行中的 Jupyter 服务器${NC}"
    echo -e "${BLUE}提示: 请先启动 Jupyter Lab：${NC}"
    echo "   jupyter lab"
    echo ""
    echo "或者使用以下命令同时启动："
    echo "   jupyter lab &"
    echo ""
    read -p "是否现在启动 Jupyter Lab? (y/n) " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}启动 Jupyter Lab...${NC}"
        jupyter lab --no-browser > /tmp/jupyter.log 2>&1 &
        JUPYTER_PID=$!
        echo -e "${GREEN}✓ Jupyter Lab 已启动 (PID: $JUPYTER_PID)${NC}"
        sleep 3
    else
        echo -e "${YELLOW}跳过启动 Jupyter Lab，请稍后手动启动${NC}"
    fi
else
    echo -e "${GREEN}✓ 检测到 Jupyter 服务器正在运行${NC}"
fi

# 启动 Token 服务
echo ""
echo -e "${YELLOW}🔧 启动 Jupyter Token 服务...${NC}"

# 检查端口 8765 是否被占用
if lsof -Pi :8765 -sTCP:LISTEN -t >/dev/null 2>&1 ; then
    echo -e "${YELLOW}⚠️  端口 8765 已被占用，Token 服务可能已在运行${NC}"
    echo -e "${GREEN}✓ 使用现有的 Token 服务${NC}"
else
    # 启动 token 服务
    python3 "$PROJECT_DIR/jupyter_token_server.py" > /tmp/jupyter_token_server.log 2>&1 &
    TOKEN_SERVER_PID=$!
    echo -e "${GREEN}✓ Token 服务已启动 (PID: $TOKEN_SERVER_PID)${NC}"
    sleep 1
fi

# 测试 token 服务
echo ""
echo -e "${YELLOW}🧪 测试 Token 服务...${NC}"
sleep 1
TOKEN_RESPONSE=$(curl -s http://127.0.0.1:8765/token 2>/dev/null || echo "")

if [ -n "$TOKEN_RESPONSE" ]; then
    echo -e "${GREEN}✓ Token 服务运行正常${NC}"
else
    echo -e "${YELLOW}⚠️  Token 服务可能未正常启动，请检查日志${NC}"
fi

# 启动文档服务（如果使用 Python 的 http.server）
echo ""
echo -e "${YELLOW}📚 启动文档服务...${NC}"

# 检查端口 3000 是否被占用（常见的文档服务端口）
if lsof -Pi :3000 -sTCP:LISTEN -t >/dev/null 2>&1 ; then
    echo -e "${YELLOW}⚠️  端口 3000 已被占用${NC}"
    DOC_PORT=3001
else
    DOC_PORT=3000
fi

# 使用 Python 的 http.server 启动文档服务
python3 -m http.server $DOC_PORT > /tmp/docs_server.log 2>&1 &
DOC_SERVER_PID=$!

echo -e "${GREEN}✓ 文档服务已启动${NC}"
echo ""
echo "=========================================="
echo -e "${GREEN}✅ 所有服务已启动！${NC}"
echo "=========================================="
echo ""
echo -e "${BLUE}📖 访问文档:${NC} http://localhost:$DOC_PORT/index.html"
echo -e "${BLUE}🔧 Token 服务:${NC} http://127.0.0.1:8765/token"
echo ""
echo -e "${YELLOW}💡 提示:${NC}"
echo "   1. 打开文档页面后，系统会自动获取 Jupyter token"
echo "   2. 现在可以直接点击文档中的 Notebook 链接"
echo "   3. 无需手动配置 token！"
echo ""
echo -e "${YELLOW}🛑 停止服务:${NC}"
echo "   按 Ctrl+C 停止所有服务"
echo "   或运行: kill $TOKEN_SERVER_PID $DOC_SERVER_PID"
echo ""

# 等待用户中断
trap "echo ''; echo -e '${YELLOW}正在停止服务...${NC}'; kill $TOKEN_SERVER_PID $DOC_SERVER_PID 2>/dev/null; exit" INT TERM

# 保持脚本运行
wait

