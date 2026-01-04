# 生成网络

## [课前测验](https://ff-quizzes.netlify.app/en/ai/quiz/33)

循环神经网络（RNN）及其门控单元变体，如长短期记忆单元（LSTM）和门控循环单元（GRU），为语言建模提供了一种机制，因为它们可以学习单词顺序并为序列中的下一个单词提供预测。这允许我们将 RNN 用于**生成任务**，如普通文本生成、机器翻译，甚至图像字幕。

> ✅ 想想您从生成任务中受益的所有时间，例如在您输入时进行文本完成。对您喜欢的应用程序进行一些研究，看看它们是否利用了 RNN。

在我们在上一个单元中讨论的 RNN 架构中，每个 RNN 单元产生下一个隐藏状态作为输出。但是，我们也可以为每个循环单元添加另一个输出，这将允许我们输出一个**序列**（其长度等于原始序列）。此外，我们可以使用在每个步骤不接受输入的 RNN 单元，只接受一些初始状态向量，然后产生输出序列。

这允许不同的神经网络架构，如下图所示：

![显示常见循环神经网络模式的图像。](images/unreasonable-effectiveness-of-rnn.jpg)

> 图片来自博客文章 [循环神经网络的非凡有效性](http://karpathy.github.io/2015/05/21/rnn-effectiveness/) 由 [Andrej Karpaty](http://karpathy.github.io/)

* **一对一**是具有一个输入和一个输出的传统神经网络
* **一对多**是接受一个输入值并生成输出值序列的生成架构。例如，如果我们想训练一个**图像字幕**网络，它将产生图片的文本描述，我们可以将图片作为输入，通过 CNN 传递它以获得其隐藏状态，然后让循环链逐字生成字幕
* **多对一**对应于我们在上一个单元中描述的 RNN 架构，如文本分类
* **多对多**，或**序列到序列**对应于诸如**机器翻译**的任务，其中我们首先让 RNN 从输入序列收集所有信息到隐藏状态，另一个 RNN 链将此状态展开为输出序列。

在本单元中，我们将专注于帮助我们生成文本的简单生成模型。为简单起见，我们将使用字符级标记化。

我们将训练这个 RNN 逐步生成文本。在每一步，我们将取长度为 `nchars` 的字符序列，并要求网络为每个输入字符生成下一个输出字符：

![显示 RNN 生成单词 'HELLO' 示例的图像。](images/rnn-generate.png)

在生成文本时（在推理期间），我们从某个**提示**开始，它通过 RNN 单元传递以生成其中间状态，然后从该状态开始生成。我们一次生成一个字符，并将状态和生成的字符传递给另一个 RNN 单元以生成下一个，直到我们生成足够的字符。

<img src="images/rnn-generate-inf.png" width="60%"/>

> 图片由作者制作

## ✍️ 练习：生成网络

在以下笔记本中继续学习：

* [使用 PyTorch 的生成网络](GenerativePyTorch.ipynb)
* [使用 TensorFlow 的生成网络](GenerativeTF.ipynb)

## 软文本生成和温度

每个 RNN 单元的输出是字符的概率分布。如果我们总是取概率最高的字符作为生成文本中的下一个字符，文本通常会在相同的字符序列之间一次又一次地"循环"，就像在这个示例中：

```
today of the second the company and a second the company ...
```

但是，如果我们查看下一个字符的概率分布，几个最高概率之间的差异可能不是很大，例如，一个字符可能具有概率 0.2，另一个 - 0.19 等。例如，当在序列 '*play*' 中寻找下一个字符时，下一个字符同样可以是空格或 **e**（如单词 *player* 中）。

这使我们得出结论，选择概率较高的字符并不总是"公平"的，因为选择第二高的可能仍然导致有意义的文本。从网络输出给出的概率分布中**采样**字符更明智。我们还可以使用参数**温度**，如果我们想添加更多随机性，它将使概率分布变平，或者如果我们想更坚持最高概率字符，则使其更陡峭。

探索如何在上面链接的笔记本中实现这种软文本生成。

## 结论

虽然文本生成本身可能很有用，但主要好处来自使用 RNN 从某个初始特征向量生成文本的能力。例如，文本生成用作机器翻译的一部分（序列到序列，在这种情况下，来自*编码器*的状态向量用于生成或*解码*翻译的消息），或生成图像的文本描述（在这种情况下，特征向量将来自 CNN 提取器）。

## 🚀 挑战

在 Microsoft Learn 上学习一些关于此主题的课程

* 使用 [PyTorch](https://docs.microsoft.com/learn/modules/intro-natural-language-processing-pytorch/6-generative-networks/?WT.mc_id=academic-77998-cacaste)/[TensorFlow](https://docs.microsoft.com/learn/modules/intro-natural-language-processing-tensorflow/5-generative-networks/?WT.mc_id=academic-77998-cacaste) 进行文本生成

## [课后测验](https://ff-quizzes.netlify.app/en/ai/quiz/34)

## 复习与自主学习

以下是一些扩展您知识的文章

* 使用马尔可夫链、LSTM 和 GPT-2 进行文本生成的不同方法：[博客文章](https://towardsdatascience.com/text-generation-gpt-2-lstm-markov-chain-9ea371820e1e)
* [Keras 文档](https://keras.io/examples/generative/lstm_character_level_text_generation/) 中的文本生成示例

## [作业](lab/README.md)

我们已经看到了如何逐字符生成文本。在实验中，您将探索词级文本生成。

