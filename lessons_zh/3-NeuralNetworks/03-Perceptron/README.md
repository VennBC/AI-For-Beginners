# 神经网络介绍：感知机

## [课前测验](https://ff-quizzes.netlify.app/en/ai/quiz/5)

实现类似现代神经网络的首次尝试之一是由康奈尔航空实验室的 Frank Rosenblatt 在 1957 年完成的。这是一个名为"Mark-1"的硬件实现，旨在识别原始几何图形，如三角形、正方形和圆形。

|      |      |
|--------------|-----------|
|<img src='images/Rosenblatt-wikipedia.jpg' alt='Frank Rosenblatt'/> | <img src='images/Mark_I_perceptron_wikipedia.jpg' alt='The Mark 1 Perceptron' />|

> 图片[来自维基百科](https://en.wikipedia.org/wiki/Perceptron)

输入图像由 20x20 光电池阵列表示，因此神经网络有 400 个输入和一个二进制输出。一个简单的网络包含一个神经元，也称为**阈值逻辑单元**。神经网络权重充当电位器，在训练阶段需要手动调整。

> ✅ 电位器是一种允许用户调整电路电阻的设备。

> 《纽约时报》当时写道：感知机是[海军]期望能够行走、说话、看、写、自我复制并意识到其存在的电子计算机的胚胎。

## 感知机模型

假设我们的模型中有 N 个特征，在这种情况下，输入向量将是大小为 N 的向量。感知机是一个**二分类**模型，即它可以区分两类输入数据。我们将假设对于每个输入向量 x，我们的感知机的输出将是 +1 或 -1，取决于类别。输出将使用以下公式计算：

y(x) = f(w<sup>T</sup>x)

其中 f 是阶跃激活函数

<!-- img src="http://www.sciweavers.org/tex2img.php?eq=f%28x%29%20%3D%20%5Cbegin%7Bcases%7D%0A%20%20%20%20%20%20%20%20%20%2B1%20%26%20x%20%5Cgeq%200%20%5C%5C%0A%20%20%20%20%20%20%20%20%20-1%20%26%20x%20%3C%200%0A%20%20%20%20%20%20%20%5Cend%7Bcases%7D%20%5C%5C%0A&bc=White&fc=Black&im=jpg&fs=12&ff=arev&edit=0" align="center" border="0" alt="f(x) = \begin{cases} +1 & x \geq 0 \\ -1 & x < 0 \end{cases} \\" width="154" height="50" / -->
<img src="images/activation-func.png"/>

## 训练感知机

要训练感知机，我们需要找到一个权重向量 w，它能够正确分类大多数值，即产生最小的**误差**。此误差 E 由**感知机准则**以下列方式定义：

E(w) = -&sum;w<sup>T</sup>x<sub>i</sub>t<sub>i</sub>

其中：

* 求和是在那些导致错误分类的训练数据点 i 上进行的
* x<sub>i</sub> 是输入数据，t<sub>i</sub> 对于负例和正例分别是 -1 或 +1。

此准则被视为权重 w 的函数，我们需要最小化它。通常，使用称为**梯度下降**的方法，我们从某个初始权重 w<sup>(0)</sup> 开始，然后在每一步根据以下公式更新权重：

w<sup>(t+1)</sup> = w<sup>(t)</sup> - &eta;&nabla;E(w)

这里 &eta; 是所谓的**学习率**，&nabla;E(w) 表示 E 的**梯度**。在我们计算梯度后，我们得到

w<sup>(t+1)</sup> = w<sup>(t)</sup> + &sum;&eta;x<sub>i</sub>t<sub>i</sub>

Python 中的算法如下所示：

```python
def train(positive_examples, negative_examples, num_iterations = 100, eta = 1):

    weights = [0,0,0] # Initialize weights (almost randomly :)
        
    for i in range(num_iterations):
        pos = random.choice(positive_examples)
        neg = random.choice(negative_examples)

        z = np.dot(pos, weights) # compute perceptron output
        if z < 0: # positive example classified as negative
            weights = weights + eta*weights.shape

        z  = np.dot(neg, weights)
        if z >= 0: # negative example classified as positive
            weights = weights - eta*weights.shape

    return weights
```

## 结论

在本课中，您了解了感知机，这是一个二分类模型，以及如何使用权重向量训练它。

## 🚀 挑战

如果您想尝试构建自己的感知机，请尝试 [Microsoft Learn 上的这个实验](https://docs.microsoft.com/en-us/azure/machine-learning/component-reference/two-class-averaged-perceptron?WT.mc_id=academic-77998-cacaste)，它使用 [Azure ML 设计器](https://docs.microsoft.com/en-us/azure/machine-learning/concept-designer?WT.mc_id=academic-77998-cacaste)。

## [课后测验](https://ff-quizzes.netlify.app/en/ai/quiz/6)

## 复习与自主学习

要了解我们如何使用感知机解决玩具问题以及现实生活中的问题，并继续学习 - 请转到 [Perceptron](Perceptron.ipynb) 笔记本。

这里还有一篇关于感知机的[有趣文章](https://towardsdatascience.com/what-is-a-perceptron-basics-of-neural-networks-c4cfea20c590)。

## [作业](lab/README.md)

在本课中，我们实现了一个用于二分类任务的感知机，并使用它来分类两个手写数字。在这个实验中，要求您完全解决数字分类问题，即确定哪个数字最有可能对应于给定图像。

* [说明](lab/README.md)
* [笔记本](lab/PerceptronMultiClass.ipynb)

