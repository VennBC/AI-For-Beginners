# 分割

我们之前学习了目标检测，它允许我们通过预测对象的*边界框*来定位图像中的对象。然而，对于某些任务，我们不仅需要边界框，还需要更精确的对象定位。这个任务称为**分割**。

## [课前测验](https://ff-quizzes.netlify.app/en/ai/quiz/23)

分割可以视为**像素分类**，而对于图像的**每个**像素，我们必须预测其类别（*背景*是类别之一）。有两种主要的分割算法：

* **语义分割**只告诉像素类别，不区分同一类别的不同对象
* **实例分割**将类别划分为不同的实例。

对于实例分割，这些羊是不同的对象，但对于语义分割，所有羊都由一个类别表示。

<img src="images/instance_vs_semantic.jpeg" width="50%">

> 图片来自[这篇博客文章](https://nirmalamurali.medium.com/image-classification-vs-semantic-segmentation-vs-instance-segmentation-625c33a08d50)

有不同的神经网络架构用于分割，但它们都具有相同的结构。在某种程度上，它类似于您之前了解的自编码器，但我们的目标不是解构原始图像，而是解构**掩码**。因此，分割网络具有以下部分：

* **编码器**从输入图像中提取特征
* **解码器**将这些特征转换为**掩码图像**，具有相同的大小和对应于类别数量的通道数。

<img src="images/segm.png" width="80%">

> 图片来自[此出版物](https://arxiv.org/pdf/2001.05566.pdf)

我们应该特别提到用于分割的损失函数。当使用经典自编码器时，我们需要测量两个图像之间的相似性，我们可以使用均方误差（MSE）来做到这一点。在分割中，目标掩码图像中的每个像素代表类别编号（沿第三维度进行 one-hot 编码），因此我们需要使用特定于分类的损失函数 - 交叉熵损失，在所有像素上平均。如果掩码是二进制的 - 使用**二进制交叉熵损失**（BCE）。

> ✅ One-hot 编码是一种将类别标签编码为长度等于类别数的向量的方法。查看[这篇关于此技术的文章](https://datagy.io/sklearn-one-hot-encode/)。

## 医学成像的分割

在本课中，我们将通过训练网络识别医学图像上的人类痣（也称为痣）来看到分割的实际应用。我们将使用 <a href="https://www.fc.up.pt/addi/ph2%20database.html">PH<sup>2</sup> 数据库</a> 的皮肤镜图像作为图像源。该数据集包含 200 张三类图像：典型痣、非典型痣和黑色素瘤。所有图像还包含相应的**掩码**，勾勒出痣的轮廓。

> ✅ 这种技术特别适合这种类型的医学成像，但您还能设想哪些其他现实世界的应用？

<img alt="navi" src="images/navi.png"/>

> 图片来自 PH<sup>2</sup> 数据库

我们将训练一个模型来从背景中分割任何痣。

## ✍️ 练习：语义分割

打开下面的笔记本以了解更多关于不同语义分割架构的信息，练习使用它们，并查看它们的实际应用。

* [语义分割 Pytorch](SemanticSegmentationPytorch.ipynb)
* [语义分割 TensorFlow](SemanticSegmentationTF.ipynb)

## [课后测验](https://ff-quizzes.netlify.app/en/ai/quiz/24)

## 结论

分割是一种非常强大的图像分类技术，超越了边界框到像素级分类。它是一种用于医学成像的技术，以及其他应用。

## 🚀 挑战

身体分割只是我们可以用人物图像做的常见任务之一。其他重要任务包括**骨架检测**和**姿态检测**。尝试 [OpenPose](https://github.com/CMU-Perceptual-Computing-Lab/openpose) 库以查看如何使用姿态检测。

## 复习与自主学习

这篇[维基百科文章](https://wikipedia.org/wiki/Image_segmentation) 提供了此技术各种应用的良好概述。自己了解更多关于实例分割和全景分割在这个研究领域的子领域。

## [作业](lab/README.md)

在这个实验中，尝试使用来自 Kaggle 的 [Segmentation Full Body MADS Dataset](https://www.kaggle.com/datasets/tapakah68/segmentation-full-body-mads-dataset) 进行**人体分割**。

