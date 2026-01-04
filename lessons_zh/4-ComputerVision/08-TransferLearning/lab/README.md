# 使用迁移学习对 Oxford 宠物进行分类

来自 [AI 初学者课程](https://github.com/microsoft/ai-for-beginners) 的实验作业。

## 任务

想象您需要为宠物托儿所开发一个应用程序来编目所有宠物。此类应用程序的一个很棒的功能是从照片中自动发现品种。在这个作业中，我们将使用迁移学习对来自 [Oxford-IIIT](https://www.robots.ox.ac.uk/~vgg/data/pets/) 宠物数据集的现实宠物图像进行分类。

## 数据集

我们将使用原始 [Oxford-IIIT](https://www.robots.ox.ac.uk/~vgg/data/pets/) 宠物数据集，其中包含 35 种不同品种的狗和猫。

要下载数据集，请使用此代码片段：

```python
!wget https://www.robots.ox.ac.uk/~vgg/data/pets/data/images.tar.gz
!tar xfz images.tar.gz
!rm images.tar.gz
```

## 起始笔记本

通过打开 [OxfordPets.ipynb](OxfordPets.ipynb) 开始实验

## 要点

迁移学习和预训练网络允许我们相对容易地解决现实世界的图像分类问题。然而，预训练网络在相似类型的图像上工作良好，如果我们开始分类非常不同的图像（例如医学图像），我们可能会得到更差的结果。

