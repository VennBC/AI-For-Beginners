# 将文本表示为张量

## [课前测验](https://ff-quizzes.netlify.app/en/ai/quiz/25)

## 文本分类

在本节的第一部分，我们将专注于**文本分类**任务。我们将使用 [AG News](https://www.kaggle.com/amananandrai/ag-news-classification-dataset) 数据集，其中包含如下新闻文章：

* 类别：Sci/Tech
* 标题：Ky. Company Wins Grant to Study Peptides (AP)
* 正文：AP - A company founded by a chemistry researcher at the University of Louisville won a grant to develop...

我们的目标将是根据文本将新闻项分类到其中一个类别。

## 表示文本

如果我们想用神经网络解决自然语言处理（NLP）任务，我们需要某种方式将文本表示为张量。计算机已经使用 ASCII 或 UTF-8 等编码将文本字符表示为映射到屏幕上字体的数字。

<img alt="显示将字符映射到 ASCII 和二进制表示的图表图像" src="images/ascii-character-map.png" width="50%"/>

> [图片来源](https://www.seobility.net/en/wiki/ASCII)

作为人类，我们理解每个字母**代表**什么，以及所有字符如何组合形成句子的单词。然而，计算机本身没有这样的理解，神经网络必须在训练期间学习含义。

因此，在表示文本时，我们可以使用不同的方法：

* **字符级表示**，当我们通过将每个字符视为数字来表示文本时。假设我们在文本语料库中有 *C* 个不同的字符，单词 *Hello* 将由 5x*C* 张量表示。每个字母将对应于 one-hot 编码中的张量列。
* **词级表示**，我们创建文本中所有单词的**词汇表**，然后使用 one-hot 编码表示单词。这种方法在某种程度上更好，因为每个字母本身没有太多含义，因此通过使用更高级的语义概念 - 单词 - 我们简化了神经网络的任务。然而，考虑到大字典大小，我们需要处理高维稀疏张量。

无论表示如何，我们首先需要将文本转换为**标记**序列，一个标记要么是字符，要么是单词，有时甚至是单词的一部分。然后，我们通常使用**词汇表**将标记转换为数字，这个数字可以使用 one-hot 编码输入到神经网络。

## N-Grams

在自然语言中，单词的精确含义只能在上下文中确定。例如，*neural network* 和 *fishing network* 的含义完全不同。考虑这一点的方法之一是在单词对上构建我们的模型，并将单词对视为单独的词汇表标记。这样，句子 *I like to go fishing* 将由以下标记序列表示：*I like*、*like to*、*to go*、*go fishing*。这种方法的问题是字典大小显著增长，像 *go fishing* 和 *go shopping* 这样的组合由不同的标记表示，尽管动词相同，但它们不共享任何语义相似性。

在某些情况下，我们可能考虑使用三元组 - 三个单词的组合 - 也是如此。因此，这种方法通常被称为**n-grams**。此外，将 n-grams 与字符级表示一起使用是有意义的，在这种情况下，n-grams 将大致对应于不同的音节。

## 词袋和 TF/IDF

在解决文本分类等任务时，我们需要能够用一个固定大小的向量表示文本，我们将使用它作为最终密集分类器的输入。这样做的最简单方法之一是组合所有单个单词表示，例如通过添加它们。如果我们添加每个单词的 one-hot 编码，我们将得到一个频率向量，显示每个单词在文本中出现多少次。文本的这种表示称为**词袋**（BoW）。

<img src="images/bow.png" width="90%"/>

> 图片由作者制作

BoW 本质上表示哪些单词出现在文本中以及以什么数量出现，这确实可以很好地指示文本的内容。例如，关于政治的新闻文章可能包含诸如 *president* 和 *country* 之类的单词，而科学出版物会有诸如 *collider*、*discovered* 等。因此，词频在许多情况下可以是文本内容的一个很好的指标。

BoW 的问题是某些常见单词，如 *and*、*is* 等，出现在大多数文本中，它们具有最高频率，掩盖了真正重要的单词。我们可以通过考虑单词在整个文档集合中出现的频率来降低这些单词的重要性。这是 TF/IDF 方法背后的主要思想，在本课附带的笔记本中有更详细的介绍。

然而，这些方法都不能完全考虑文本的**语义**。我们需要更强大的神经网络模型来做到这一点，我们将在本节的后面讨论。

## ✍️ 练习：文本表示

在以下笔记本中继续学习：

* [使用 PyTorch 进行文本表示](TextRepresentationPyTorch.ipynb)
* [使用 TensorFlow 进行文本表示](TextRepresentationTF.ipynb)

## 结论

到目前为止，我们已经研究了可以为不同单词添加频率权重的技术。然而，它们无法表示含义或顺序。正如著名语言学家 J. R. Firth 在 1935 年所说，"单词的完整含义总是上下文的，任何脱离上下文的意义研究都不能被认真对待。"我们将在课程后面学习如何使用语言建模从文本中捕获上下文信息。

## 🚀 挑战

尝试使用词袋和不同数据模型的其他练习。您可能会受到 [Kaggle 上的这个竞赛](https://www.kaggle.com/competitions/word2vec-nlp-tutorial/overview/part-1-for-beginners-bag-of-words) 的启发

## [课后测验](https://ff-quizzes.netlify.app/en/ai/quiz/26)

## 复习与自主学习

在 [Microsoft Learn](https://docs.microsoft.com/learn/modules/intro-natural-language-processing-pytorch/?WT.mc_id=academic-77998-cacaste) 上练习您的文本嵌入和词袋技术技能

## [作业：笔记本](assignment.md)

