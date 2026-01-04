# 注意力机制和 Transformer

## [课前测验](https://ff-quizzes.netlify.app/en/ai/quiz/35)

NLP 领域最重要的问题之一是**机器翻译**，这是 Google Translate 等工具的基础任务。在本节中，我们将专注于机器翻译，或者更一般地说，任何*序列到序列*任务（也称为**句子转导**）。

使用 RNN，序列到序列由两个循环网络实现，其中一个网络，**编码器**，将输入序列折叠为隐藏状态，而另一个网络，**解码器**，将此隐藏状态展开为翻译结果。这种方法有几个问题：

* 编码器网络的最终状态很难记住句子的开头，从而导致长句子的模型质量差
* 序列中的所有单词对结果具有相同的影响。然而，实际上，输入序列中的特定单词通常对顺序输出比其他单词具有更大的影响。

**注意力机制**提供了一种方法来加权每个输入向量对 RNN 的每个输出预测的上下文影响。它的实现方式是在输入 RNN 和输出 RNN 的中间状态之间创建快捷方式。这样，在生成输出符号 y<sub>t</sub> 时，我们将考虑所有输入隐藏状态 h<sub>i</sub>，具有不同的权重系数 &alpha;<sub>t,i</sub>。

![显示带有加法注意力层的编码器/解码器模型的图像](./images/encoder-decoder-attention.png)

> 带有加法注意力机制的编码器-解码器模型在 [Bahdanau et al., 2015](https://arxiv.org/pdf/1409.0473.pdf) 中，引用自[这篇博客文章](https://lilianweng.github.io/lil-log/2018/06/24/attention-attention.html)

注意力矩阵 {&alpha;<sub>i,j</sub>} 将表示某些输入单词在输出序列中给定单词的生成中发挥的程度。以下是这种矩阵的示例：

![显示 RNNsearch-50 找到的示例对齐的图像，来自 Bahdanau - arviz.org](./images/bahdanau-fig3.png)

> 图来自 [Bahdanau et al., 2015](https://arxiv.org/pdf/1409.0473.pdf) (图 3)

注意力机制负责 NLP 中当前或接近当前最先进水平的大部分。然而，添加注意力大大增加了模型参数的数量，这导致了 RNN 的扩展问题。扩展 RNN 的关键约束是模型的循环性质使得批处理和并行化训练具有挑战性。在 RNN 中，序列的每个元素都需要按顺序处理，这意味着它不能轻易并行化。

![带注意力的编码器解码器](images/EncDecAttention.gif)

> 图来自 [Google 的博客](https://research.googleblog.com/2016/09/a-neural-network-for-machine.html)

注意力机制的采用与这一约束相结合，导致了我们现在知道和使用的现在最先进的 Transformer 模型的创建，如 BERT 到 Open-GPT3。

## Transformer 模型

Transformer 背后的主要思想之一是避免 RNN 的顺序性质，并创建一个在训练期间可并行化的模型。这是通过实现两个思想来实现的：

* 位置编码
* 使用自注意力机制来捕获模式而不是 RNN（或 CNN）（这就是介绍 transformer 的论文被称为*[注意力就是您所需要的](https://arxiv.org/abs/1706.03762)*的原因

### 位置编码/嵌入

位置编码的思想如下。
1. 当使用 RNN 时，标记的相对位置由步数表示，因此不需要显式表示。
2. 但是，一旦我们切换到注意力，我们需要知道序列内标记的相对位置。
3. 为了获得位置编码，我们用序列中标记位置的序列（即，数字序列 0,1, ...）来增强我们的标记序列。
4. 然后我们将标记位置与标记嵌入向量混合。为了将位置（整数）转换为向量，我们可以使用不同的方法：

* 可训练嵌入，类似于标记嵌入。这是我们在这里考虑的方法。我们在标记及其位置上应用嵌入层，产生相同维度的嵌入向量，然后我们将它们加在一起。
* 固定位置编码函数，如原始论文中提出的。

<img src="images/pos-embedding.png" width="50%"/>

> 图片由作者制作

我们通过位置嵌入获得的结果嵌入了原始标记及其在序列中的位置。

### 多头自注意力

接下来，我们需要捕获序列内的一些模式。为此，transformer 使用**自注意力**机制，这本质上是应用于与输入和输出相同的序列的注意力。应用自注意力允许我们考虑句子内的**上下文**，并查看哪些单词是相互关联的。例如，它允许我们看到哪些单词被共指引用，如 *it*，并且还考虑上下文：

![](images/CoreferenceResolution.png)

> 图片来自 [Google 博客](https://research.googleblog.com/2017/08/transformer-novel-neural-network.html)

在 transformer 中，我们使用**多头注意力**以便为网络提供捕获几种不同类型的依赖关系的能力，例如长期与短期单词关系、共指与其他关系等。

[TensorFlow 笔记本](TransformersTF.ipynb) 包含有关 transformer 层实现的更多详细信息。

### 编码器-解码器注意力

在 transformer 中，注意力在两个地方使用：

* 使用自注意力捕获输入文本内的模式
* 执行序列翻译 - 它是编码器和解码器之间的注意力层。

编码器-解码器注意力与本节开头描述的 RNN 中使用的注意力机制非常相似。此动画图解释了编码器-解码器注意力的作用。

![显示如何在 transformer 模型中执行评估的动画 GIF。](./images/transformer-animated-explanation.gif)

由于每个输入位置独立映射到每个输出位置，transformer 可以比 RNN 更好地并行化，这使得更大和更具表现力的语言模型成为可能。每个注意力头可用于学习单词之间的不同关系，从而改善下游自然语言处理任务。

## BERT

**BERT**（来自 Transformer 的双向编码器表示）是一个非常庞大的多层 transformer 网络，*BERT-base* 有 12 层，*BERT-large* 有 24 层。该模型首先在大量文本数据语料库（WikiPedia + 书籍）上使用无监督训练（预测句子中的屏蔽单词）进行预训练。在预训练期间，模型吸收了显著水平的语言理解，然后可以使用其他数据集通过微调来利用。此过程称为**迁移学习**。

![来自 http://jalammar.github.io/illustrated-bert/ 的图片](images/jalammarBERT-language-modeling-masked-lm.png)

> 图片[来源](http://jalammar.github.io/illustrated-bert/)

## ✍️ 练习：Transformer

在以下笔记本中继续学习：

* [PyTorch 中的 Transformer](TransformersPyTorch.ipynb)
* [TensorFlow 中的 Transformer](TransformersTF.ipynb)

## 结论

在本课中，您了解了 Transformer 和注意力机制，这些都是 NLP 工具箱中的基本工具。Transformer 架构有许多变体，包括 BERT、DistilBERT。BigBird、OpenGPT3 等可以微调。[HuggingFace 包](https://github.com/huggingface/) 提供了使用 PyTorch 和 TensorFlow 训练这些架构中的许多架构的存储库。

## 🚀 挑战

阅读这篇关于 Transformer 的精彩文章：[Illustrated Transformer](http://jalammar.github.io/illustrated-transformer/)，并尝试使用 HuggingFace 库中的预训练 BERT 模型来解决一些 NLP 任务。

## [课后测验](https://ff-quizzes.netlify.app/en/ai/quiz/36)

## 复习与自主学习

* [Illustrated Transformer](http://jalammar.github.io/illustrated-transformer/) - 一篇关于 Transformer 架构的精彩文章
* [Illustrated BERT](http://jalammar.github.io/illustrated-bert/) - 关于 BERT 的详细文章
* [HuggingFace 文档](https://huggingface.co/docs/transformers/index) - 使用预训练 Transformer 模型的完整指南

## [作业：笔记本](assignment.md)

