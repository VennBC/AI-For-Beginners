# 著名的 CNN 架构

### VGG-16

VGG-16 是一个在 2014 年 ImageNet top-5 分类中达到 92.7% 准确率的网络。它具有以下层结构：

![ImageNet 层](images/vgg-16-arch1.jpg)

如您所见，VGG 遵循传统的金字塔架构，这是卷积-池化层的序列。

![ImageNet 金字塔](images/vgg-16-arch.jpg)

> 图片来自 [Researchgate](https://www.researchgate.net/figure/Vgg16-model-structure-To-get-the-VGG-NIN-model-we-replace-the-2-nd-4-th-6-th-7-th_fig2_335194493)

### ResNet

ResNet 是 Microsoft Research 在 2015 年提出的模型系列。ResNet 的主要思想是使用**残差块**：

<img src="images/resnet-block.png" width="300"/>

> 图片来自[这篇论文](https://arxiv.org/pdf/1512.03385.pdf)

使用恒等直通的原因是让我们的层预测前一层结果与残差块输出之间的**差异** - 因此得名*残差*。这些块更容易训练，可以构建具有数百个这样的块的网络（最常见的变体是 ResNet-52、ResNet-101 和 ResNet-152）。

您也可以将此网络视为能够根据数据集调整其复杂性。最初，当您开始训练网络时，权重值很小，大部分信号通过直通恒等层。随着训练的进行和权重变大，网络参数的重要性增加，网络调整以适应所需的表达能力以正确分类训练图像。

### Google Inception

Google Inception 架构将这一思想更进一步，并将每个网络层构建为几个不同路径的组合：

<img src="images/inception.png" width="400"/>

> 图片来自 [Researchgate](https://www.researchgate.net/figure/Inception-module-with-dimension-reductions-left-and-schema-for-Inception-ResNet-v1_fig2_355547454)

在这里，我们需要强调 1x1 卷积的作用，因为起初它们没有意义。为什么我们需要用 1x1 滤波器遍历图像？但是，您需要记住，卷积滤波器也适用于多个深度通道（最初 - RGB 颜色，在后续层中 - 不同滤波器的通道），1x1 卷积用于使用不同的可训练权重将这些输入通道混合在一起。它也可以被视为在通道维度上的下采样（池化）。

这里是[关于该主题的优秀博客文章](https://medium.com/analytics-vidhya/talented-mr-1x1-comprehensive-look-at-1x1-convolution-in-deep-learning-f6b355825578)，以及[原始论文](https://arxiv.org/pdf/1312.4400.pdf)。

### MobileNet

MobileNet 是一个尺寸减小的模型系列，适用于移动设备。如果您资源不足并且可以牺牲一点准确率，请使用它们。它们背后的主要思想是所谓的**深度可分离卷积**，它允许通过空间卷积和深度通道上的 1x1 卷积的组合来表示卷积滤波器。这显著减少了参数数量，使网络尺寸更小，并且也更容易用更少的数据训练。

这里是[关于 MobileNet 的优秀博客文章](https://medium.com/analytics-vidhya/image-classification-with-mobilenet-cc6fbb2cd470)。

## 结论

在本单元中，您已经了解了计算机视觉神经网络背后的主要概念 - 卷积网络。为图像分类、目标检测甚至图像生成网络提供动力的现实架构都基于 CNN，只是有更多层和一些额外的训练技巧。

## 🚀 挑战

在随附的笔记本中，底部有关于如何获得更高准确率的注释。进行一些实验，看看您是否可以达到更高的准确率。

## [课后测验](https://ff-quizzes.netlify.app/en/ai/quiz/14)

## 复习与自主学习

虽然 CNN 最常用于计算机视觉任务，但它们通常擅长提取固定大小的模式。例如，如果我们处理声音，我们可能还想使用 CNN 在音频信号中寻找某些特定模式 - 在这种情况下，滤波器将是一维的（这个 CNN 将被称为 1D-CNN）。此外，有时使用 3D-CNN 在多维空间中提取特征，例如视频上发生的某些事件 - CNN 可以捕获特征随时间变化的某些模式。对可以使用 CNN 完成的其他任务进行一些复习和自主学习。

## [作业](lab/README.md)

在这个实验中，您的任务是对不同的猫和狗品种进行分类。这些图像比 MNIST 数据集更复杂，维度更高，并且有超过 10 个类别。

