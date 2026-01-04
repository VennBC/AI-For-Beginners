# 语言建模

语义嵌入，如 Word2Vec 和 GloVe，实际上是迈向**语言建模**的第一步 - 创建以某种方式*理解*（或*表示*）语言性质的模型。

## [课前测验](https://ff-quizzes.netlify.app/en/ai/quiz/29)

语言建模背后的主要思想是以无监督的方式在未标记的数据集上训练它们。这很重要，因为我们有大量未标记的文本可用，而标记文本的数量总是受到我们可以在标记上花费的努力量的限制。大多数情况下，我们可以构建可以**预测文本中缺失单词**的语言模型，因为很容易在文本中屏蔽随机单词并将其用作训练样本。

## 训练嵌入

在我们之前的示例中，我们使用了预训练的语义嵌入，但看看如何训练这些嵌入是很有趣的。有几个可能的思想可以使用：

* **N-Gram** 语言建模，当我们通过查看 N 个先前的标记（N-gram）来预测标记时
* **连续词袋**（CBoW），当我们在标记序列 $W_{-N}$, ..., $W_N$ 中预测中间标记 $W_0$ 时。
* **跳元**，我们从中间标记 $W_0$ 预测一组相邻标记 {$W_{-N},\dots, W_{-1}, W_1,\dots, W_N$}。

![将单词转换为向量的论文图像](../14-Embeddings/images/example-algorithms-for-converting-words-to-vectors.png)

> 图片来自[这篇论文](https://arxiv.org/pdf/1301.3781.pdf)

## ✍️ 示例笔记本：训练 CBoW 模型

在以下笔记本中继续学习：

* [使用 TensorFlow 训练 CBoW Word2Vec](CBoW-TF.ipynb)
* [使用 PyTorch 训练 CBoW Word2Vec](CBoW-PyTorch.ipynb)


## 结论

在上一课中，我们看到词嵌入像魔法一样工作！现在我们知道训练词嵌入不是一个非常复杂的任务，如果需要，我们应该能够为特定领域的文本训练我们自己的词嵌入。

## [课后测验](https://ff-quizzes.netlify.app/en/ai/quiz/30)

## 复习与自主学习

* [PyTorch 关于语言建模的官方教程](https://pytorch.org/tutorials/beginner/nlp/word_embeddings_tutorial.html)。
* [TensorFlow 关于训练 Word2Vec 模型的官方教程](https://www.TensorFlow.org/tutorials/text/word2vec)。
* 使用 **gensim** 框架在几行代码中训练最常用的嵌入在[此文档](https://pytorch.org/tutorials/beginner/nlp/word_embeddings_tutorial.html)中描述。

## 🚀 [作业：训练 Skip-Gram 模型](lab/README.md)

在实验中，我们挑战您修改本课的代码以训练 skip-gram 模型而不是 CBoW。[阅读详细信息](lab/README.md)

