# 命名实体识别

到目前为止，我们主要专注于一个 NLP 任务 - 分类。然而，还有其他可以用神经网络完成的 NLP 任务。这些任务之一是**[命名实体识别](https://wikipedia.org/wiki/Named-entity_recognition)**（NER），它涉及识别文本中的特定实体，如地点、人名、日期时间间隔、化学公式等。

## [课前测验](https://ff-quizzes.netlify.app/en/ai/quiz/37)

## 使用 NER 的示例

假设您想开发一个自然语言聊天机器人，类似于 Amazon Alexa 或 Google Assistant。智能聊天机器人的工作方式是通过对输入句子进行文本分类来*理解*用户想要什么。此分类的结果是所谓的**意图**，它确定聊天机器人应该做什么。

<img alt="Bot NER" src="images/bot-ner.png" width="50%"/>

> 图片由作者制作

但是，用户可能作为短语的一部分提供一些参数。例如，在询问天气时，她可能指定位置或日期。机器人应该能够理解这些实体，并在执行操作之前相应地填充参数槽。这正是 NER 的用武之地。

> ✅ 另一个例子是[分析科学医学论文](https://soshnikov.com/science/analyzing-medical-papers-with-azure-and-text-analytics-for-health/)。我们需要寻找的主要事情之一是特定的医学术语，如疾病和医疗物质。虽然少数疾病可能可以使用子字符串搜索提取，但更复杂的实体，如化合物和药物名称，需要更复杂的方法。

## NER 作为标记分类

NER 模型本质上是**标记分类模型**，因为对于每个输入标记，我们需要决定它是否属于实体，如果是 - 属于哪个实体类。

考虑以下论文标题：

**Tricuspid valve regurgitation** 和 **lithium carbonate** **toxicity** 在新生儿中。

这里的实体是：

* Tricuspid valve regurgitation 是一种疾病（`DIS`）
* Lithium carbonate 是一种化学物质（`CHEM`）
* Toxicity 也是一种疾病（`DIS`）

请注意，一个实体可以跨越多个标记。并且，在这种情况下，我们需要区分两个连续的实体。因此，通常为每个实体使用两个类 - 一个指定实体的第一个标记（通常使用 `B-` 前缀，表示**b**eginning），另一个 - 实体的延续（`I-`，表示**i**nner 标记）。我们还使用 `O` 作为类来表示所有**o**ther 标记。这种标记标记称为 [BIO 标记](https://en.wikipedia.org/wiki/Inside%E2%80%93outside%E2%80%93beginning_(tagging))（或 IOB）。标记后，我们的标题将如下所示：

标记 | 标签
------|-----
Tricuspid | B-DIS
valve | I-DIS
regurgitation | I-DIS
and | O
lithium | B-CHEM
carbonate | I-CHEM
toxicity | B-DIS
in | O
a | O
newborn | O
infant | O
. | O

由于我们需要在标记和类之间建立一对一对应关系，我们可以从这张图片中训练最右边的**多对多**神经网络模型：

![显示常见循环神经网络模式的图像。](../17-GenerativeNetworks/images/unreasonable-effectiveness-of-rnn.jpg)

> *图片来自 [Andrej Karpathy](http://karpathy.github.io/) 的[这篇博客文章](http://karpathy.github.io/2015/05/21/rnn-effectiveness/)。NER 标记分类模型对应于此图片上最右边的网络架构。*

## 训练 NER 模型

由于 NER 模型本质上是标记分类模型，我们可以使用我们已经熟悉的 RNN 来完成此任务。在这种情况下，循环网络的每个块将返回标记 ID。以下示例笔记本显示了如何训练 LSTM 进行标记分类。

## ✍️ 示例笔记本：NER

在以下笔记本中继续学习：

* [使用 TensorFlow 的 NER](NER-TF.ipynb)

## 结论

NER 模型是**标记分类模型**，这意味着它可以用于执行标记分类。这是 NLP 中非常常见的任务，有助于识别文本中的特定实体，包括地点、名称、日期等。

## 🚀 挑战

完成下面链接的作业，训练一个用于医学术语的命名实体识别模型，然后在不同的数据集上尝试它。

## [课后测验](https://ff-quizzes.netlify.app/en/ai/quiz/38)

## 复习与自主学习

阅读博客 [循环神经网络的非凡有效性](http://karpathy.github.io/2015/05/21/rnn-effectiveness/) 并按照该文章中的进一步阅读部分来加深您的知识。

## [作业](lab/README.md)

在本课的作业中，您必须训练一个医学实体识别模型。您可以从训练本课中描述的 LSTM 模型开始，然后继续使用 BERT transformer 模型。阅读[说明](lab/README.md) 以获取所有详细信息。

