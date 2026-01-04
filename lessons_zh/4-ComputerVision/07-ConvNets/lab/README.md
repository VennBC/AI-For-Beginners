# 宠物面部分类

来自 [AI 初学者课程](https://github.com/microsoft/ai-for-beginners) 的实验作业。

## 任务

想象您需要为宠物托儿所开发一个应用程序来编目所有宠物。此类应用程序的一个很棒的功能是从照片中自动发现品种。这可以使用神经网络成功完成。

您需要训练一个卷积神经网络，使用**宠物面部**数据集对不同的猫和狗品种进行分类。

## 数据集

我们将使用 [Oxford-IIIT 宠物数据集](https://www.robots.ox.ac.uk/~vgg/data/pets/)，其中包含 37 种不同品种的狗和猫的图像。

![我们将处理的数据集](images/data.png)

要下载数据集，请使用此代码片段：

```python
!wget https://thor.robots.ox.ac.uk/~vgg/data/pets/images.tar.gz
!tar xfz images.tar.gz
!rm images.tar.gz
```

**注意：** Oxford-IIIT 宠物数据集图像按文件名组织（例如，`Abyssinian_1.jpg`、`Bengal_2.jpg`）。笔记本包含将这些图像组织到特定品种的子目录中以便于分类的代码。

## 起始笔记本

通过打开 [PetFaces.ipynb](PetFaces.ipynb) 开始实验

## 要点

您已经从头开始解决了相对复杂的图像分类问题！有很多类别，您仍然能够获得合理的准确率！测量 top-k 准确率也是有意义的，因为很容易混淆一些即使对人类来说也不明显不同的类别。

