#!/bin/bash

# 使用 pip 安装依赖的备选方案（适用于 conda SSL 错误）

set -e

echo "=========================================="
echo "使用 pip 安装 AI-For-Beginners 环境"
echo "=========================================="
echo ""

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 检查 conda 是否安装
if ! command -v conda &> /dev/null; then
    echo -e "${RED}错误: 未找到 conda 命令${NC}"
    exit 1
fi

# 初始化变量
USE_VENV=false

# 初始化 conda（如果需要）
echo -e "${YELLOW}步骤 1: 初始化 conda...${NC}"
source $(conda info --base)/etc/profile.d/conda.sh

# 检查环境是否已存在（仅检查 conda 环境，venv 单独处理）
if conda env list 2>/dev/null | grep -q "ai4beg"; then
    echo -e "${YELLOW}环境 ai4beg 已存在，是否删除并重新创建？(y/n)${NC}"
    read -p "> " answer
    if [[ $answer == "y" || $answer == "Y" ]]; then
        conda env remove --name ai4beg -y 2>/dev/null || true
    else
        echo "使用现有环境..."
        conda activate ai4beg
        exit 0
    fi
fi

# 检查是否已有 venv
USE_VENV=false
if [ -d ~/ai4beg_env ]; then
    echo -e "${YELLOW}发现已有虚拟环境 ~/ai4beg_env，是否删除并重新创建？(y/n)${NC}"
    read -p "> " answer
    if [[ $answer == "y" || $answer == "Y" ]]; then
        rm -rf ~/ai4beg_env
    else
        echo "使用现有虚拟环境..."
        source ~/ai4beg_env/bin/activate
        exit 0
    fi
fi

# 创建基础 Python 环境
echo -e "${YELLOW}步骤 2: 创建基础 Python 环境...${NC}"

# 首先尝试正常创建
echo "尝试 Python 3.10（正常模式）..."
if conda create --name ai4beg python=3.10 -y 2>/dev/null; then
    echo -e "${GREEN}✓ 使用 Python 3.10 创建环境成功${NC}"
elif conda create --name ai4beg python=3.9 -y 2>/dev/null; then
    echo -e "${GREEN}✓ 使用 Python 3.9 创建环境成功${NC}"
elif conda create --name ai4beg python=3.8 -y 2>/dev/null; then
    echo -e "${GREEN}✓ 使用 Python 3.8 创建环境成功${NC}"
else
    echo -e "${YELLOW}正常模式失败，尝试禁用 SSL 验证...${NC}"
    # 临时禁用 SSL 验证
    conda config --set ssl_verify false
    
    # 再次尝试创建环境
    if conda create --name ai4beg python=3.10 -y 2>/dev/null; then
        echo -e "${GREEN}✓ 使用 Python 3.10 创建环境成功（已禁用 SSL 验证）${NC}"
    elif conda create --name ai4beg python=3.9 -y 2>/dev/null; then
        echo -e "${GREEN}✓ 使用 Python 3.9 创建环境成功（已禁用 SSL 验证）${NC}"
    elif conda create --name ai4beg python=3.8 -y 2>/dev/null; then
        echo -e "${GREEN}✓ 使用 Python 3.8 创建环境成功（已禁用 SSL 验证）${NC}"
    else
        echo -e "${RED}✗ 无法创建 conda 环境${NC}"
        echo -e "${YELLOW}尝试使用系统 Python 创建虚拟环境...${NC}"
        
        # 使用 Python venv 作为备选
        # 优先尝试 Python 3.10+（keras 3.12.0 需要）
        PYTHON_CMD=""
        if command -v python3.12 &> /dev/null; then
            PYTHON_CMD="python3.12"
            PYTHON_VERSION=$(python3.12 --version 2>&1 | awk '{print $2}')
        elif command -v python3.11 &> /dev/null; then
            PYTHON_CMD="python3.11"
            PYTHON_VERSION=$(python3.11 --version 2>&1 | awk '{print $2}')
        elif command -v python3.10 &> /dev/null; then
            PYTHON_CMD="python3.10"
            PYTHON_VERSION=$(python3.10 --version 2>&1 | awk '{print $2}')
        elif command -v python3 &> /dev/null; then
            PYTHON_CMD="python3"
            PYTHON_VERSION=$(python3 --version 2>&1 | awk '{print $2}')
        fi
        
        if [ -n "$PYTHON_CMD" ]; then
            PYTHON_MAJOR_MINOR=$(echo $PYTHON_VERSION | cut -d. -f1,2)
            echo "检测到 Python $PYTHON_VERSION"
            
            # 检查版本是否 >= 3.10
            PYTHON_MAJOR=$(echo $PYTHON_MAJOR_MINOR | cut -d. -f1)
            PYTHON_MINOR=$(echo $PYTHON_MAJOR_MINOR | cut -d. -f2)
            
            if [ "$PYTHON_MAJOR" -lt 3 ] || ([ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -lt 10 ]); then
                echo -e "${YELLOW}警告: Python $PYTHON_VERSION 可能不兼容 keras 3.12.0（需要 Python 3.10+）${NC}"
                echo -e "${YELLOW}将使用兼容的 keras 版本...${NC}"
            fi
            
            # 删除旧环境（如果存在）
            if [ -d ~/ai4beg_env ]; then
                echo "删除旧的虚拟环境..."
                rm -rf ~/ai4beg_env
            fi
            
            # 创建虚拟环境
            $PYTHON_CMD -m venv ~/ai4beg_env
            echo -e "${GREEN}✓ 已创建虚拟环境在 ~/ai4beg_env (使用 $PYTHON_VERSION)${NC}"
            USE_VENV=true
        else
            echo -e "${RED}✗ 未找到 Python 3${NC}"
            exit 1
        fi
    fi
    
    # 重新启用 SSL 验证（如果之前禁用了）
    conda config --set ssl_verify true
fi

# 激活环境
echo -e "${YELLOW}步骤 3: 激活环境...${NC}"
if [ "$USE_VENV" = true ] || [ -d ~/ai4beg_env ]; then
    # 使用 venv
    source ~/ai4beg_env/bin/activate
    echo -e "${GREEN}✓ 已激活虚拟环境${NC}"
else
    # 使用 conda
    conda activate ai4beg
    echo -e "${GREEN}✓ 已激活 conda 环境${NC}"
fi

# 配置 pip 使用国内镜像源（解决 SSL 问题）
echo -e "${YELLOW}步骤 4: 配置 pip 使用国内镜像源...${NC}"
mkdir -p ~/.pip
cat > ~/.pip/pip.conf << 'EOF'
[global]
index-url = https://pypi.tuna.tsinghua.edu.cn/simple
trusted-host = pypi.tuna.tsinghua.edu.cn
timeout = 120
EOF
echo -e "${GREEN}✓ 已配置使用清华大学 PyPI 镜像源${NC}"

# 升级 pip
echo -e "${YELLOW}步骤 5: 升级 pip...${NC}"
pip install --upgrade pip --trusted-host pypi.tuna.tsinghua.edu.cn || pip install --upgrade pip

# 安装依赖
echo -e "${YELLOW}步骤 6: 安装 Python 依赖包...${NC}"
if [ -f requirements.txt ]; then
    # 尝试使用镜像源安装（带 trusted-host）
    echo "使用清华大学镜像源安装依赖..."
    pip install -r requirements.txt --trusted-host pypi.tuna.tsinghua.edu.cn || {
        echo -e "${YELLOW}镜像源安装失败，尝试使用官方源（带 trusted-host）...${NC}"
        pip install -r requirements.txt --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org || {
            echo -e "${YELLOW}尝试禁用 SSL 验证...${NC}"
            # 设置环境变量禁用 SSL 验证（最后手段）
            export PIP_INDEX_URL=https://pypi.tuna.tsinghua.edu.cn/simple
            export PIP_TRUSTED_HOST=pypi.tuna.tsinghua.edu.cn
            pip install -r requirements.txt || {
                echo -e "${RED}安装失败，请检查网络连接或手动安装${NC}"
                exit 1
            }
        }
    }
else
    echo -e "${RED}错误: 未找到 requirements.txt${NC}"
    exit 1
fi

# 安装 Jupyter 相关包
echo -e "${YELLOW}步骤 7: 安装 Jupyter 相关包...${NC}"
pip install jupyter jupyterlab ipykernel ipython ipywidgets matplotlib==3.9 numpy==1.26 scikit-learn scipy==1.13 requests==2.32 --trusted-host pypi.tuna.tsinghua.edu.cn || {
    pip install jupyter jupyterlab ipykernel ipython ipywidgets matplotlib==3.9 numpy==1.26 scikit-learn scipy==1.13 requests==2.32 --trusted-host pypi.org --trusted-host pypi.python.org --trusted-host files.pythonhosted.org || {
        pip install jupyter jupyterlab ipykernel ipython ipywidgets matplotlib==3.9 numpy==1.26 scikit-learn scipy==1.13 requests==2.32
    }
}

# 尝试安装 PyTorch（如果可能）
echo -e "${YELLOW}步骤 8: 安装 PyTorch...${NC}"
if pip install torch torchvision torchtext torchdata --trusted-host pypi.tuna.tsinghua.edu.cn 2>/dev/null; then
    echo -e "${GREEN}✓ PyTorch 安装成功${NC}"
else
    echo -e "${YELLOW}⚠ PyTorch 安装失败，可以稍后手动安装${NC}"
    echo "  安装命令: pip install torch torchvision torchtext torchdata"
fi

# 尝试安装 OpenCV
echo -e "${YELLOW}步骤 9: 安装 OpenCV...${NC}"
if pip install opencv-python --trusted-host pypi.tuna.tsinghua.edu.cn 2>/dev/null; then
    echo -e "${GREEN}✓ OpenCV 安装成功${NC}"
else
    echo -e "${YELLOW}⚠ OpenCV 安装失败，可以稍后手动安装${NC}"
    echo "  安装命令: pip install opencv-python"
fi

echo ""
echo -e "${GREEN}=========================================="
echo "✓ 环境安装完成！"
echo "==========================================${NC}"
echo ""
echo "下一步操作："
echo ""
echo "1. 激活环境："
if [ "$USE_VENV" = true ] || [ -d ~/ai4beg_env ]; then
    echo "   source ~/ai4beg_env/bin/activate"
else
    echo "   source \$(conda info --base)/etc/profile.d/conda.sh"
    echo "   conda activate ai4beg"
fi
echo ""
echo "2. 启动 Jupyter Lab："
echo "   jupyter lab"
echo ""
echo "3. 验证安装："
echo "   python -c \"import torch; print('PyTorch:', torch.__version__)\""
echo "   python -c \"import tensorflow as tf; print('TensorFlow:', tf.__version__)\""
echo ""

