#!/bin/bash

# 下载缺失的数据文件脚本
# 根据 notebook_check_summary.md 中的说明下载所需数据

set -e  # 遇到错误立即退出

echo "开始下载缺失的数据文件..."

# 1. 复制或下载 mnist.pkl.gz 到 PerceptronMultiClass 目录
echo "1. 准备 mnist.pkl.gz 到 3-NeuralNetworks/03-Perceptron/lab/"
cd lessons_zh/3-NeuralNetworks/03-Perceptron/lab/
if [ ! -f "mnist.pkl.gz" ]; then
    # 首先尝试从本地 data 目录复制
    if [ -f "../../../../data/mnist.pkl.gz" ]; then
        echo "   从本地 data 目录复制..."
        cp ../../../../data/mnist.pkl.gz .
        echo "   ✅ 复制完成"
    else
        echo "   从网络下载 mnist.pkl.gz..."
        curl -L --max-time 30 -o mnist.pkl.gz https://raw.githubusercontent.com/microsoft/AI-For-Beginners/main/data/mnist.pkl.gz || {
            echo "   ⚠️  下载失败，请手动下载"
        }
        if [ -f "mnist.pkl.gz" ]; then
            echo "   ✅ 下载完成"
        fi
    fi
else
    echo "   ✅ 文件已存在，跳过"
fi
cd - > /dev/null

# 2. 复制或下载 mnist.pkl.gz 到 MyFW_MNIST 目录
echo "2. 准备 mnist.pkl.gz 到 3-NeuralNetworks/04-OwnFramework/lab/"
cd lessons_zh/3-NeuralNetworks/04-OwnFramework/lab/
if [ ! -f "mnist.pkl.gz" ]; then
    # 首先尝试从本地 data 目录复制
    if [ -f "../../../../data/mnist.pkl.gz" ]; then
        echo "   从本地 data 目录复制..."
        cp ../../../../data/mnist.pkl.gz .
        echo "   ✅ 复制完成"
    else
        echo "   从网络下载 mnist.pkl.gz..."
        curl -L --max-time 30 -o mnist.pkl.gz https://raw.githubusercontent.com/microsoft/AI-For-Beginners/main/data/mnist.pkl.gz || {
            echo "   ⚠️  下载失败，请手动下载"
        }
        if [ -f "mnist.pkl.gz" ]; then
            echo "   ✅ 下载完成"
        fi
    fi
else
    echo "   ✅ 文件已存在，跳过"
fi
cd - > /dev/null

# 3. 下载 kagglecatsanddogs_5340.zip 到 TransferLearning 目录
echo "3. 下载 kagglecatsanddogs_5340.zip 到 4-ComputerVision/08-TransferLearning/"
cd lessons_zh/4-ComputerVision/08-TransferLearning/
if [ ! -f "kagglecatsanddogs_5340.zip" ]; then
    echo "   下载 kagglecatsanddogs_5340.zip (这可能需要一些时间，约200MB)..."
    curl -L -o kagglecatsanddogs_5340.zip https://download.microsoft.com/download/3/E/1/3E1C3F21-ECDB-4869-8368-6DEBA77B919F/kagglecatsanddogs_5340.zip
    echo "   ✅ 下载完成"
    echo "   提示: 需要解压时运行: unzip kagglecatsanddogs_5340.zip"
else
    echo "   ✅ 文件已存在，跳过"
fi
cd - > /dev/null

echo ""
echo "✅ 所有可自动下载的文件已完成！"
echo ""
echo "⚠️  注意: ner_dataset.csv 需要从 Kaggle 手动下载"
echo "   下载地址: https://www.kaggle.com/datasets/abhinavwalia95/entity-annotated-corpus"
echo "   下载后请将文件放到: lessons_zh/5-NLP/19-NER/ner_dataset.csv"
echo ""
echo "📝 其他数据文件说明:"
echo "   - Oxford-IIIT Pet Dataset: PetFaces.ipynb 中包含自动下载代码"
echo "   - oxcats.tar.gz: Clip.ipynb 中包含自动下载代码"
echo "   - onto.ttl: 已存在于 2-Symbolic/data/onto.ttl"

