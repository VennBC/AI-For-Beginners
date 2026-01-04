#!/bin/bash

# AI-For-Beginners Conda SSL 错误修复脚本
# 此脚本提供多种方法来解决 conda SSL 错误

set -e

echo "=========================================="
echo "Conda SSL 错误修复脚本"
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
    echo "请先安装 Miniconda 或 Anaconda"
    exit 1
fi

echo -e "${GREEN}✓ 检测到 conda: $(conda --version)${NC}"
echo ""

# 方法 1: 更新 conda（推荐首先尝试）
echo -e "${YELLOW}方法 1: 更新 conda 到最新版本...${NC}"
if conda update -y conda; then
    echo -e "${GREEN}✓ Conda 更新成功${NC}"
else
    echo -e "${RED}✗ Conda 更新失败，继续尝试其他方法...${NC}"
fi
echo ""

# 方法 2: 清理 conda 缓存
echo -e "${YELLOW}方法 2: 清理 conda 缓存...${NC}"
conda clean --all -y
echo -e "${GREEN}✓ 缓存清理完成${NC}"
echo ""

# 方法 3: 配置 conda 使用国内镜像（适用于中国大陆用户）
echo -e "${YELLOW}方法 3: 配置 conda 使用国内镜像源（可选）...${NC}"
read -p "是否使用清华大学镜像源？(y/n): " use_mirror
if [[ $use_mirror == "y" || $use_mirror == "Y" ]]; then
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/main
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/pkgs/free
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/conda-forge
    conda config --add channels https://mirrors.tuna.tsinghua.edu.cn/anaconda/cloud/pytorch
    conda config --set show_channel_urls yes
    echo -e "${GREEN}✓ 已配置使用清华大学镜像源${NC}"
else
    echo "跳过镜像源配置"
fi
echo ""

# 方法 4: 临时禁用 SSL 验证（不推荐，但有时必要）
echo -e "${YELLOW}方法 4: 尝试创建环境（如果仍有 SSL 错误，将提供禁用 SSL 验证的选项）...${NC}"
echo ""

# 尝试正常创建环境
conda env create --name ai4beg --file environment.yml 2>&1 | tee /tmp/conda_error.log
ENV_CREATE_EXIT_CODE=${PIPESTATUS[0]}

if [ $ENV_CREATE_EXIT_CODE -eq 0 ]; then
    echo -e "${GREEN}✓ 环境创建成功！${NC}"
    echo ""
    echo "下一步："
    echo "  source \$(conda info --base)/etc/profile.d/conda.sh"
    echo "  conda activate ai4beg"
    echo "  jupyter lab"
    exit 0
else
    if grep -q "SSL\|SSLError\|certificate" /tmp/conda_error.log; then
        echo -e "${RED}检测到 SSL 错误${NC}"
        echo ""
        echo -e "${YELLOW}方法 5: 使用禁用 SSL 验证的方式（临时方案）...${NC}"
        read -p "是否尝试禁用 SSL 验证？(y/n): " disable_ssl
        if [[ $disable_ssl == "y" || $disable_ssl == "Y" ]]; then
            echo "警告: 禁用 SSL 验证存在安全风险，仅用于临时解决网络问题"
            conda config --set ssl_verify false
            echo -e "${GREEN}✓ 已禁用 SSL 验证${NC}"
            echo ""
            echo "重新尝试创建环境..."
            if conda env create --name ai4beg --file environment.yml; then
                echo -e "${GREEN}✓ 环境创建成功！${NC}"
                echo ""
                echo "重要: 创建完成后，建议重新启用 SSL 验证："
                echo "  conda config --set ssl_verify true"
                exit 0
            else
                echo -e "${RED}✗ 仍然失败${NC}"
            fi
        fi
    fi
fi

echo ""
echo -e "${YELLOW}方法 6: 使用 pip 作为备选方案...${NC}"
read -p "是否使用 pip 安装依赖？(y/n): " use_pip
if [[ $use_pip == "y" || $use_pip == "Y" ]]; then
    echo "创建基础 Python 环境..."
    conda create --name ai4beg python=3.10 -y || conda create --name ai4beg python=3.9 -y || conda create --name ai4beg python=3.8 -y
    
    echo "激活环境并安装依赖..."
    source $(conda info --base)/etc/profile.d/conda.sh
    conda activate ai4beg
    
    echo "使用 pip 安装依赖..."
    pip install --upgrade pip
    pip install -r requirements.txt
    
    # 安装 conda 特定的包
    echo "安装 Jupyter 相关包..."
    pip install jupyter jupyterlab ipykernel ipython ipywidgets
    
    echo -e "${GREEN}✓ 使用 pip 安装完成${NC}"
    echo ""
    echo "下一步："
    echo "  conda activate ai4beg"
    echo "  jupyter lab"
    exit 0
fi

echo ""
echo -e "${RED}所有方法都尝试过了。请检查：${NC}"
echo "1. 网络连接是否正常"
echo "2. 是否在代理或防火墙后面（需要配置代理）"
echo "3. 系统时间是否正确"
echo "4. 尝试使用 VPN 或更换网络"
echo ""
echo "如果问题持续，可以："
echo "- 使用 Docker/DevContainer（推荐）"
echo "- 使用 GitHub Codespaces"
echo "- 使用 Google Colab 运行 Notebooks"

