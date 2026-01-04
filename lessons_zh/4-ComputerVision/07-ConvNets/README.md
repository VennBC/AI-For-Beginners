# 卷积神经网络

我们之前看到神经网络在处理图像方面相当不错，甚至单层感知机也能够以合理的准确率识别来自 MNIST 数据集的手写数字。然而，MNIST 数据集非常特殊，所有数字都居中在图像内，这使得任务更简单。

## [课前测验](https://ff-quizzes.netlify.app/en/ai/quiz/13)

在现实生活中，我们希望能够在图片上识别对象，而不管它们在图像中的确切位置。计算机视觉与通用分类不同，因为当我们试图在图片中找到某个对象时，我们正在扫描图像以寻找某些特定的**模式**及其组合。例如，在寻找猫时，我们首先可能寻找可以形成胡须的水平线，然后某些胡须的组合可以告诉我们这实际上是一张猫的图片。某些模式的相对位置和存在是重要的，而不是它们在图像上的确切位置。

为了提取模式，我们将使用**卷积滤波器**的概念。如您所知，图像由 2D 矩阵或具有颜色深度的 3D 张量表示。应用滤波器意味着我们取相对较小的**滤波器核**矩阵，并且对于原始图像中的每个像素，我们计算与相邻点的加权平均值。我们可以将其视为一个小窗口在整个图像上滑动，并根据滤波器核矩阵中的权重对所有像素进行平均。

![垂直边缘滤波器](images/filter-vert.png) | ![水平边缘滤波器](images/filter-horiz.png)
----|----

> 图片由 Dmitry Soshnikov 制作

例如，如果我们将 3x3 垂直边缘和水平边缘滤波器应用于 MNIST 数字，我们可以在原始图像中有垂直和水平边缘的地方获得高亮（例如高值）。因此，这两个滤波器可用于"寻找"边缘。类似地，我们可以设计不同的滤波器来寻找其他低级模式：

<img src="images/lmfilters.jpg" width="500" align="center"/>


> [Leung-Malik 滤波器组](https://www.robots.ox.ac.uk/~vgg/research/texclass/filters.html) 的图像

但是，虽然我们可以设计滤波器来手动提取某些模式，但我们也可以以网络将自动学习模式的方式设计网络。这是 CNN 背后的主要思想之一。

## CNN 背后的主要思想

CNN 的工作方式基于以下重要思想：

* 卷积滤波器可以提取模式
* 我们可以以自动训练滤波器的方式设计网络
* 我们可以使用相同的方法在高级特征中查找模式，而不仅仅是在原始图像中。因此 CNN 特征提取在特征层次结构上工作，从低级像素组合开始，一直到图片部分的高级组合。

![分层特征提取](images/FeatureExtractionCNN.png)

> 图片来自 [Hislop-Lynch 的论文](https://www.semanticscholar.org/paper/Computer-vision-based-pedestrian-trajectory-Hislop-Lynch/26e6f74853fc9bbb7487b06dc2cf095d36c9021d)，基于[他们的研究](https://dl.acm.org/doi/abs/10.1145/1553374.1553453)

## ✍️ 练习：卷积神经网络

让我们继续探索卷积神经网络的工作原理，以及如何通过浏览相应的笔记本来实现可训练的滤波器：

* [卷积神经网络 - PyTorch](ConvNetsPyTorch.ipynb)
* [卷积神经网络 - TensorFlow](ConvNetsTF.ipynb)

## 金字塔架构

大多数用于图像处理的 CNN 遵循所谓的金字塔架构。应用于原始图像的第一个卷积层通常具有相对较少的滤波器（8-16），这些滤波器对应于不同的像素组合，例如水平/垂直线或笔划。在下一级，我们减少网络的空间维度，并增加滤波器的数量，这对应于简单特征的更多可能组合。随着每一层，当我们向最终分类器移动时，图像的空间维度减小，滤波器的数量增加。

作为示例，让我们看看 VGG-16 的架构，这是一个在 2014 年 ImageNet 的 top-5 分类中达到 92.7% 准确率的网络：

![ImageNet 层](images/vgg-16-arch1.jpg)

![ImageNet 金字塔](images/vgg-16-arch.jpg)

> 图片来自 [Researchgate](https://www.researchgate.net/figure/Vgg16-model-structure-To-get-the-VGG-NIN-model-we-replace-the-2-nd-4-th-6-th-7-th_fig2_335194493)

## 最著名的 CNN 架构

[继续学习最著名的 CNN 架构](CNN_Architectures.md)

