# 人体分割

来自 [AI 初学者课程](https://github.com/microsoft/ai-for-beginners) 的实验作业。

## 任务

在视频制作中，例如，在天气预报中，我们经常需要从相机中切出人物图像并将其放在其他镜头的顶部。这通常使用**色度键**技术完成，当人在统一颜色背景前拍摄时，然后移除背景。在这个实验中，我们将训练神经网络模型来切出人体轮廓。

## 数据集

我们将使用来自 Kaggle 的 [Segmentation Full Body MADS Dataset](https://www.kaggle.com/datasets/tapakah68/segmentation-full-body-mads-dataset)。从 Kaggle 手动下载数据集。

## 起始笔记本

通过打开 [BodySegmentation.ipynb](BodySegmentation.ipynb) 开始实验

## 要点

身体分割只是我们可以用人物图像做的常见任务之一。其他重要任务包括**骨架检测**和**姿态检测**。查看 [OpenPose](https://github.com/CMU-Perceptual-Computing-Lab/openpose) 库以了解如何实现这些任务。

