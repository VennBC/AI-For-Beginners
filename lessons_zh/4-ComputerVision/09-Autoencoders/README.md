# 自编码器

在训练 CNN 时，问题之一是我们需要大量标记数据。在图像分类的情况下，我们需要将图像分成不同的类别，这是一项手动工作。

## [课前测验](https://ff-quizzes.netlify.app/en/ai/quiz/17)

但是，我们可能希望使用原始（未标记）数据来训练 CNN 特征提取器，这称为**自监督学习**。我们将使用训练图像作为网络输入和输出，而不是标签。**自编码器**的主要思想是，我们将有一个**编码器网络**，将输入图像转换为某个**潜在空间**（通常它只是某个较小尺寸的向量），然后是**解码器网络**，其目标将是重建原始图像。

> ✅ [自编码器](https://wikipedia.org/wiki/Autoencoder) 是"一种用于学习未标记数据的高效编码的人工神经网络类型"。

由于我们训练自编码器以尽可能多地捕获原始图像中的信息以进行准确重建，网络试图找到输入图像的最佳**嵌入**以捕获含义。

![自编码器图](images/autoencoder_schema.jpg)

> 图片来自 [Keras 博客](https://blog.keras.io/building-autoencoders-in-keras.html)

## 使用自编码器的场景

虽然重建原始图像本身似乎没有用，但有一些场景自编码器特别有用：

* **降低图像维度以进行可视化**或**训练图像嵌入**。通常自编码器比 PCA 给出更好的结果，因为它考虑了图像的空间性质和分层特征。
* **去噪**，即从图像中去除噪声。因为噪声携带大量无用信息，自编码器无法将所有信息都拟合到相对较小的潜在空间中，因此它只捕获图像的重要部分。在训练去噪器时，我们从原始图像开始，并使用人工添加噪声的图像作为自编码器的输入。
* **超分辨率**，提高图像分辨率。我们从高分辨率图像开始，并使用较低分辨率的图像作为自编码器输入。
* **生成模型**。一旦我们训练了自编码器，解码器部分可用于从随机潜在向量开始创建新对象。

## 变分自编码器（VAE）

传统自编码器以某种方式降低输入数据的维度，找出输入图像的重要特征。然而，潜在向量通常没有太大意义。换句话说，以 MNIST 数据集为例，找出哪些数字对应于不同的潜在向量并不是一件容易的事，因为接近的潜在向量不一定对应于相同的数字。

另一方面，为了训练*生成*模型，最好对潜在空间有一些理解。这个想法将我们引向**变分自编码器**（VAE）。

VAE 是学习预测潜在参数的*统计分布*的自编码器，所谓的**潜在分布**。例如，我们可能希望潜在向量以某个均值 z<sub>mean</sub> 和标准差 z<sub>sigma</sub>（均值和标准差都是某个维度 d 的向量）正态分布。VAE 中的编码器学习预测这些参数，然后解码器从该分布中取一个随机向量来重建对象。

总结：

 * 从输入向量，我们预测 `z_mean` 和 `z_log_sigma`（我们预测其对数而不是预测标准差本身）
 * 我们从分布 N(z<sub>mean</sub>,exp(z<sub>log\_sigma</sub>)) 中采样向量 `sample`
 * 解码器尝试使用 `sample` 作为输入向量解码原始图像

 <img src="images/vae.png" width="50%">

> 图片来自 [这篇博客文章](https://ijdykeman.github.io/ml/2016/12/21/cvae.html) 由 Isaak Dykeman

变分自编码器使用由两部分组成的复杂损失函数：

* **重建损失**是显示重建图像与目标接近程度的损失函数（可以是均方误差或 MSE）。它与普通自编码器中的损失函数相同。
* **KL 损失**，确保潜在变量分布保持接近正态分布。它基于 [Kullback-Leibler 散度](https://www.countbayesie.com/blog/2017/5/9/kullback-leibler-divergence-explained) 的概念 - 一种估计两个统计分布相似程度的指标。

VAE 的一个重要优势是它们允许我们相对容易地生成新图像，因为我们知道从哪个分布采样潜在向量。例如，如果我们在 MNIST 上用 2D 潜在向量训练 VAE，我们可以改变潜在向量的分量以获得不同的数字：

<img alt="vaemnist" src="images/vaemnist.png" width="50%"/>

> 图片由 [Dmitry Soshnikov](http://soshnikov.com) 制作

观察图像如何相互融合，当我们开始从潜在参数空间的不同部分获取潜在向量时。我们也可以在 2D 中可视化这个空间：

<img alt="vaemnist cluster" src="images/vaemnist-diag.png" width="50%"/> 

> 图片由 [Dmitry Soshnikov](http://soshnikov.com) 制作

## ✍️ 练习：自编码器

在以下相应的笔记本中了解更多关于自编码器的信息：

* [TensorFlow 中的自编码器](AutoencodersTF.ipynb)
* [PyTorch 中的自编码器](AutoEncodersPyTorch.ipynb)

## 自编码器的属性

* **数据特定** - 它们仅适用于它们已训练的图像类型。例如，如果我们在花朵上训练超分辨率网络，它在肖像上不会很好地工作。这是因为网络可以通过从训练数据集学习的特征中获取精细细节来产生更高分辨率的图像。
* **有损** - 重建的图像与原始图像不同。损失的性质由训练期间使用的*损失函数*定义
* 适用于**未标记数据**

## [课后测验](https://ff-quizzes.netlify.app/en/ai/quiz/18)

## 结论

在本课中，您了解了 AI 科学家可用的各种类型的自编码器。您学习了如何构建它们，以及如何使用它们来重建图像。您还了解了 VAE 以及如何使用它来生成新图像。

## 🚀 挑战

在本课中，您了解了使用自编码器处理图像。但它们也可以用于音乐！查看 Magenta 项目的 [MusicVAE](https://magenta.tensorflow.org/music-vae) 项目，该项目使用自编码器学习重建音乐。使用此库进行一些[实验](https://colab.research.google.com/github/magenta/magenta-demos/blob/master/colab-notebooks/Multitrack_MusicVAE.ipynb)，看看您可以创建什么。

## [课后测验](https://ff-quizzes.netlify.app/en/ai/quiz/16)

## 复习与自主学习

作为参考，在这些资源中阅读更多关于自编码器的内容：

* [在 Keras 中构建自编码器](https://blog.keras.io/building-autoencoders-in-keras.html)
* [NeuroHive 上的博客文章](https://neurohive.io/ru/osnovy-data-science/variacionnyj-avtojenkoder-vae/)
* [变分自编码器解释](https://kvfrans.com/variational-autoencoders-explained/)
* [条件变分自编码器](https://ijdykeman.github.io/ml/2016/12/21/cvae.html)

## 作业

在[使用 TensorFlow 的笔记本](AutoencodersTF.ipynb)的末尾，您会找到一个"任务" - 将其用作您的作业。

