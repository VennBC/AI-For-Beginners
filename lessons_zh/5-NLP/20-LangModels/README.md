# 预训练大语言模型

在我们之前的所有任务中，我们都在训练神经网络以使用标记数据集执行某些任务。对于大型 transformer 模型，如 BERT，我们以自监督方式使用语言建模来构建语言模型，然后通过进一步的特定领域训练专门用于特定的下游任务。然而，已经证明大型语言模型也可以在没有任何特定领域训练的情况下解决许多任务。能够做到这一点的模型家族称为 **GPT**：生成式预训练 Transformer。

## [课前测验](https://ff-quizzes.netlify.app/en/ai/quiz/39)

## 文本生成和困惑度

神经网络能够在没有下游训练的情况下执行一般任务的想法在 [语言模型是无监督多任务学习者](https://cdn.openai.com/better-language-models/language_models_are_unsupervised_multitask_learners.pdf) 论文中提出。主要思想是许多其他任务可以使用**文本生成**建模，因为理解文本本质上意味着能够产生它。因为模型在包含人类知识的大量文本上训练，它也变得对广泛的主题有知识。

> 理解并能够产生文本也需要了解我们周围的世界。人们也在很大程度上通过阅读来学习，GPT 网络在这方面是相似的。

文本生成网络通过预测下一个单词的概率 $$P(w_N)$$ 来工作。然而，下一个单词的无条件概率等于该单词在文本语料库中的频率。GPT 能够给我们下一个单词的**条件概率**，给定前面的单词：$$P(w_N | w_{n-1}, ..., w_0)$$

> 您可以在我们的 [数据科学初学者课程](https://github.com/microsoft/Data-Science-For-Beginners/tree/main/1-Introduction/04-stats-and-probability) 中阅读更多关于概率的内容

语言生成模型的质量可以使用**困惑度**来定义。它是一个内在指标，允许我们在没有任何特定任务数据集的情况下测量模型质量。它基于*句子概率*的概念 - 模型为可能真实的句子分配高概率（即模型不会对它感到**困惑**），并为不太有意义的句子分配低概率（例如 *Can it does what?*）。当我们给模型来自真实文本语料库的句子时，我们希望它们具有高概率和低**困惑度**。在数学上，它被定义为测试集的归一化逆概率：
$$
\mathrm{Perplexity}(W) = \sqrt[N]{1\over P(W_1,...,W_N)}
$$ 

**您可以使用 [Hugging Face 的 GPT 驱动的文本编辑器](https://transformer.huggingface.co/doc/gpt2-large) 尝试文本生成**。在此编辑器中，您开始编写文本，按 **[TAB]** 将为您提供几个完成选项。如果它们太短，或者您对它们不满意 - 再次按 [TAB]，您将获得更多选项，包括更长的文本片段。

## GPT 是一个家族

GPT 不是单个模型，而是由 [OpenAI](https://openai.com) 开发和训练的模型集合。

在 GPT 模型下，我们有：

| [GPT-2](https://huggingface.co/docs/transformers/model_doc/gpt2#openai-gpt2) | [GPT 3](https://openai.com/research/language-models-are-few-shot-learners) | [GPT-4](https://openai.com/gpt-4) |
| -- | -- | -- |
|最多 15 亿参数的语言模型。 | 最多 1750 亿参数的语言模型 | 100T 参数并接受图像和文本输入并输出文本。 |


GPT-3 和 GPT-4 模型可作为 [Microsoft Azure 的认知服务](https://azure.microsoft.com/en-us/services/cognitive-services/openai-service/#overview?WT.mc_id=academic-77998-cacaste) 和 [OpenAI API](https://openai.com/api/) 使用。

## 提示工程

因为 GPT 已经在大量数据上训练以理解语言和代码，它们提供响应输入（提示）的输出。提示是 GPT 输入或查询，通过它向模型提供关于它们接下来完成的任务的指令。为了获得期望的结果，您需要最有效的提示，这涉及选择正确的单词、格式、短语甚至符号。这种方法是[提示工程](https://learn.microsoft.com/en-us/shows/ai-show/the-basics-of-prompt-engineering-with-azure-openai-service?WT.mc_id=academic-77998-bethanycheum)

[此文档](https://learn.microsoft.com/en-us/semantic-kernel/prompt-engineering/?WT.mc_id=academic-77998-bethanycheum) 为您提供有关提示工程的更多信息。

## ✍️ 示例笔记本：[使用 OpenAI-GPT](GPT-PyTorch.ipynb)

在以下笔记本中继续学习：

* [使用 OpenAI-GPT 和 Hugging Face Transformers 生成文本](GPT-PyTorch.ipynb)

## 结论

新的通用预训练语言模型不仅建模语言结构，还包含大量自然语言。因此，它们可以有效地用于在零样本或少样本设置中解决一些 NLP 任务。

## [课后测验](https://ff-quizzes.netlify.app/en/ai/quiz/40)

