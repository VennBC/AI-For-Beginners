# 多模态网络

在 transformer 模型成功解决 NLP 任务后，相同或相似的架构已应用于计算机视觉任务。人们对构建能够*结合*视觉和自然语言能力的模型越来越感兴趣。OpenAI 进行了这样一次尝试，它被称为 CLIP 和 DALL.E。

## 对比图像预训练（CLIP）

CLIP 的主要思想是能够比较文本提示和图像，并确定图像与提示的对应程度。

![CLIP 架构](images/clip-arch.png)

> *图片来自[这篇博客文章](https://openai.com/blog/clip/)*

该模型在从互联网获得的图像及其标题上进行训练。对于每个批次，我们取 N 对（图像，文本），并将它们转换为一些向量表示 I<sub>1</sub>,..., I<sub>N</sub> / T<sub>1</sub>, ..., T<sub>N</sub>。然后将这些表示匹配在一起。损失函数定义为最大化对应一对的向量之间的余弦相似度（例如 I<sub>i</sub> 和 T<sub>i</sub>），并最小化所有其他对之间的余弦相似度。这就是这种方法被称为**对比**的原因。

CLIP 模型/库可从 [OpenAI GitHub](https://github.com/openai/CLIP) 获得。该方法在[这篇博客文章](https://openai.com/blog/clip/)中描述，并在[这篇论文](https://arxiv.org/pdf/2103.00020.pdf)中更详细地描述。

一旦这个模型经过预训练，我们可以给它一批图像和一批文本提示，它将返回概率张量。CLIP 可用于多个任务：

**图像分类**

假设我们需要在猫、狗和人类之间对图像进行分类。在这种情况下，我们可以给模型一个图像和一系列文本提示："*一张猫的图片*"、"*一张狗的图片*"、"*一张人类的图片*"。在得到的 3 个概率向量中，我们只需要选择具有最高值的索引。

![用于图像分类的 CLIP](images/clip-class.png)

> *图片来自[这篇博客文章](https://openai.com/blog/clip/)*

**基于文本的图像搜索**

我们也可以做相反的事情。如果我们有一个图像集合，我们可以将这个集合传递给模型，以及一个文本提示 - 这将给我们最类似于给定提示的图像。

## ✍️ 示例：[使用 CLIP 进行图像分类和图像搜索](Clip.ipynb)

打开 [Clip.ipynb](Clip.ipynb) 笔记本以查看 CLIP 的实际应用。

## 使用 VQGAN+ CLIP 进行图像生成

CLIP 也可以用于从文本提示进行**图像生成**。为了做到这一点，我们需要一个**生成器模型**，它能够基于某些向量输入生成图像。其中一个这样的模型称为 [VQGAN](https://compvis.github.io/taming-transformers/)（向量量化 GAN）。

VQGAN 与普通 [GAN](../../4-ComputerVision/10-GANs/README.md) 区分开来的主要思想如下：
* 使用自回归 transformer 架构生成组成图像的上下文丰富的视觉部分序列。这些视觉部分又由 [CNN](../../4-ComputerVision/07-ConvNets/README.md) 学习
* 使用子图像判别器，检测图像的部分是"真实的"还是"虚假的"（与传统 GAN 中的"全有或全无"方法不同）。

在 [Taming Transformers](https://compvis.github.io/taming-transformers/) 网站上了解更多关于 VQGAN 的信息。

VQGAN 和传统 GAN 之间的重要区别之一是，后者可以从任何输入向量产生不错的图像，而 VQGAN 可能产生不连贯的图像。因此，我们需要进一步指导图像创建过程，这可以使用 CLIP 来完成。

![VQGAN+CLIP 架构](images/vqgan.png)

为了生成对应于文本提示的图像，我们从一些随机编码向量开始，该向量通过 VQGAN 传递以产生图像。然后使用 CLIP 产生损失函数，显示图像与文本提示的对应程度。然后目标是使用反向传播调整输入向量参数来最小化此损失。

实现 VQGAN+CLIP 的一个很好的库是 [Pixray](http://github.com/pixray/pixray)

![Pixray 生成的图片](images/a_closeup_watercolor_portrait_of_young_male_teacher_of_literature_with_a_book.png) |  ![pixray 生成的图片](images/a_closeup_oil_portrait_of_young_female_teacher_of_computer_science_with_a_computer.png) | ![Pixray 生成的图片](images/a_closeup_oil_portrait_of_old_male_teacher_of_math.png)
----|----|----
从提示 *a closeup watercolor portrait of young male teacher of literature with a book* 生成的图片 | 从提示 *a closeup oil portrait of young female teacher of computer science with a computer* 生成的图片 | 从提示 *a closeup oil portrait of old male teacher of mathematics in front of blackboard* 生成的图片

> 图片来自 [Dmitry Soshnikov](http://soshnikov.com) 的**人工教师**集合

## DALL-E
### [DALL-E 1](https://openai.com/research/dall-e)
DALL-E 是 GPT-3 的一个版本，训练用于从提示生成图像。它已经用 120 亿个参数进行了训练。

与 CLIP 不同，DALL-E 将文本和图像都作为图像和文本的单个标记流接收。因此，从多个提示中，您可以基于文本生成图像。

### [DALL-E 2](https://openai.com/dall-e-2)
DALL.E 1 和 2 之间的主要区别是它生成更逼真的图像和艺术。

使用 DALL-E 生成图像的示例：
![Pixray 生成的图片](images/DALL·E%202023-06-20%2015.56.56%20-%20a%20closeup%20watercolor%20portrait%20of%20young%20male%20teacher%20of%20literature%20with%20a%20book.png) |  ![pixray 生成的图片](images/DALL·E%202023-06-20%2015.57.43%20-%20a%20closeup%20oil%20portrait%20of%20young%20female%20teacher%20of%20computer%20science%20with%20a%20computer.png) | ![Pixray 生成的图片](images/DALL·E%202023-06-20%2015.58.42%20-%20%20a%20closeup%20oil%20portrait%20of%20old%20male%20teacher%20of%20mathematics%20in%20front%20of%20blackboard.png)
----|----|----
从提示 *a closeup watercolor portrait of young male teacher of literature with a book* 生成的图片 | 从提示 *a closeup oil portrait of young female teacher of computer science with a computer* 生成的图片 | 从提示 *a closeup oil portrait of old male teacher of mathematics in front of blackboard* 生成的图片

## 参考文献

* VQGAN 论文：[Taming Transformers for High-Resolution Image Synthesis](https://compvis.github.io/taming-transformers/paper/paper.pdf)
* CLIP 论文：[Learning Transferable Visual Models From Natural Language Supervision](https://arxiv.org/pdf/2103.00020.pdf)

