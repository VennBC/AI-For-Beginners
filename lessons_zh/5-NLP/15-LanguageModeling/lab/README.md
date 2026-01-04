# 训练 Skip-Gram 模型

来自 [AI 初学者课程](https://github.com/microsoft/ai-for-beginners) 的实验作业。

## 任务

在这个实验中，我们挑战您使用 Skip-Gram 技术训练 Word2Vec 模型。训练一个带有嵌入的网络，以在 $N$ 标记宽的 Skip-Gram 窗口中预测相邻单词。您可以使用[本课的代码](../CBoW-TF.ipynb)，并稍微修改它。

## 数据集

欢迎您使用任何书籍。您可以在 [Project Gutenberg](https://www.gutenberg.org/) 找到很多免费文本，例如，这里是 [Alice's Adventures in Wonderland](https://www.gutenberg.org/files/11/11-0.txt)) 的直接链接，由 Lewis Carroll 编写。或者，您可以使用莎士比亚的戏剧，您可以使用以下代码获取：

```python
path_to_file = tf.keras.utils.get_file(
   'shakespeare.txt', 
   'https://storage.googleapis.com/download.tensorflow.org/data/shakespeare.txt')
text = open(path_to_file, 'rb').read().decode(encoding='utf-8')
```

## 探索！

如果您有时间并想更深入地了解该主题，请尝试探索几件事：

* 嵌入大小如何影响结果？
* 不同的文本样式如何影响结果？
* 取几个非常不同类型的单词及其同义词，获得它们的向量表示，应用 PCA 将维度减少到 2，并在 2D 空间中绘制它们。您看到任何模式吗？

