# NER

来自 [AI 初学者课程](https://github.com/microsoft/ai-for-beginners) 的实验作业。

## 任务

在这个实验中，您需要训练用于医学术语的命名实体识别模型。

## 数据集

为了训练 NER 模型，我们需要带有医学实体的正确标记数据集。[BC5CDR 数据集](https://biocreative.bioinformatics.udel.edu/tasks/biocreative-v/track-3-cdr/) 包含来自 1500 多篇论文的标记疾病和化学实体。您可以在他们的网站上注册后下载数据集。

BC5CDR 数据集如下所示：

```
6794356|t|Tricuspid valve regurgitation and lithium carbonate toxicity in a newborn infant.
6794356|a|A newborn with massive tricuspid regurgitation, atrial flutter, congestive heart failure, and a high serum lithium level is described. This is the first patient to initially manifest tricuspid regurgitation and atrial flutter, and the 11th described patient with cardiac disease among infants exposed to lithium compounds in the first trimester of pregnancy. Sixty-three percent of these infants had tricuspid valve involvement. Lithium carbonate may be a factor in the increasing incidence of congenital heart disease when taken during early pregnancy. It also causes neurologic depression, cyanosis, and cardiac arrhythmia when consumed prior to delivery.
6794356	0	29	Tricuspid valve regurgitation	Disease	D014262
6794356	34	51	lithium carbonate	Chemical	D016651
6794356	52	60	toxicity	Disease	D064420
...
```

在此数据集中，前两行是论文标题和摘要，然后有单独的实体，在标题+摘要块内有开始和结束位置。除了实体类型，您还会获得该实体在某个医学本体中的本体 ID。

您需要编写一些 Python 代码将其转换为 BIO 编码。

## 网络

NER 的第一次尝试可以通过使用 LSTM 网络来完成，如我们在课程中看到的示例。然而，在 NLP 任务中，[transformer 架构](https://en.wikipedia.org/wiki/Transformer_(machine_learning_model))，特别是 [BERT 语言模型](https://en.wikipedia.org/wiki/BERT_(language_model)) 显示出更好的结果。预训练的 BERT 模型理解语言的一般结构，可以用相对较小的数据集和计算成本针对特定任务进行微调。

由于我们计划将 NER 应用于医学场景，使用在医学文本上训练的 BERT 模型是有意义的。Microsoft Research 发布了一个名为 [PubMedBERT][PubMedBERT] 的预训练模型（[出版物][PubMedBERT-Pub]），该模型使用来自 [PubMed](https://pubmed.ncbi.nlm.nih.gov/) 存储库的文本进行了微调。

训练 transformer 模型的*事实*标准是 [Hugging Face Transformers](https://huggingface.co/) 库。它还包含一个社区维护的预训练模型存储库，包括 PubMedBERT。要加载和使用此模型，我们只需要几行代码：

```python
model_name = "microsoft/BiomedNLP-PubMedBERT-base-uncased-abstract"
classes = ... # number of classes: 2*entities+1
tokenizer = AutoTokenizer.from_pretrained(model_name)
model = BertForTokenClassification.from_pretrained(model_name, classes)
```

这为我们提供了 `model` 本身，使用 `classes` 数量的类为标记分类任务构建，以及可以将输入文本拆分为标记的 `tokenizer` 对象。您需要将数据集转换为 BIO 格式，考虑 PubMedBERT 标记化。您可以使用[这段 Python 代码](https://gist.github.com/shwars/580b55684be3328eb39ecf01b9cbbd88) 作为灵感。

## 要点

此任务非常接近如果您想从大量自然语言文本中获得更多见解，您可能会遇到的实际任务。在我们的案例中，我们可以将训练好的模型应用于[COVID 相关论文数据集](https://www.kaggle.com/allen-institute-for-ai/CORD-19-research-challenge)，看看我们能够获得哪些见解。[这篇博客文章](https://soshnikov.com/science/analyzing-medical-papers-with-azure-and-text-analytics-for-health/) 和[这篇论文](https://www.mdpi.com/2504-2289/6/1/4) 描述了可以使用 NER 在此论文语料库上进行的研究。

