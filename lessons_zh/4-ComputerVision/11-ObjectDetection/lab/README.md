# 使用 Hollywood Heads 数据集进行头部检测

来自 [AI 初学者课程](https://github.com/microsoft/ai-for-beginners) 的实验作业。

## 任务

计算视频监控摄像头流中的人数是一项重要任务，它将允许我们估计商店中的访客数量、餐厅的繁忙时间等。为了解决此任务，我们需要能够从不同角度检测人头。为了训练目标检测模型来检测人头，我们可以使用 [Hollywood Heads 数据集](https://www.di.ens.fr/willow/research/headdetection/)。

## 数据集

[Hollywood Heads 数据集](https://www.di.ens.fr/willow/research/headdetection/release/HollywoodHeads.zip) 包含在来自好莱坞电影的 224,740 个电影帧中注释的 369,846 个人头。它以 [https://host.robots.ox.ac.uk/pascal/VOC/](PASCAL VOC) 格式提供，其中对于每个图像还有一个 XML 描述文件，如下所示：

```xml
<annotation>
	<folder>HollywoodHeads</folder>
	<filename>mov_021_149390.jpeg</filename>
	<source>
		<database>HollywoodHeads 2015 Database</database>
		<annotation>HollywoodHeads 2015</annotation>
		<image>WILLOW</image>
	</source>
	<size>
		<width>608</width>
		<height>320</height>
		<depth>3</depth>
	</size>
	<segmented>0</segmented>
	<object>
		<name>head</name>
		<bndbox>
			<xmin>201</xmin>
			<ymin>1</ymin>
			<xmax>480</xmax>
			<ymax>263</ymax>
		</bndbox>
		<difficult>0</difficult>
	</object>
	<object>
		<name>head</name>
		<bndbox>
			<xmin>3</xmin>
			<ymin>4</ymin>
			<xmax>241</xmax>
			<ymax>285</ymax>
		</bndbox>
		<difficult>0</difficult>
	</object>
</annotation>
```

在此数据集中，只有一个对象类 `head`，对于每个头，您会获得边界框的坐标。您可以使用 Python 库解析 XML，或使用[此库](https://pypi.org/project/pascal-voc/) 直接处理 PASCAL VOC 格式。

## 训练目标检测

您可以使用以下方法之一训练目标检测模型：

* 使用 [Azure Custom Vision](https://docs.microsoft.com/azure/cognitive-services/custom-vision-service/quickstarts/object-detection?tabs=visual-studio&WT.mc_id=academic-77998-cacaste) 及其 Python API 在云中以编程方式训练模型。Custom vision 将无法使用超过几百张图像来训练模型，因此您可能需要限制数据集。
* 使用 [Keras 教程](https://keras.io/examples/vision/retinanet/) 中的示例来训练 RetunaNet 模型。
* 使用 [torchvision.models.detection.RetinaNet](https://pytorch.org/vision/stable/_modules/torchvision/models/detection/retinanet.html) torchvision 中的内置模块。

## 要点

目标检测是行业中经常需要的任务。虽然有一些服务可用于执行目标检测（如 [Azure Custom Vision](https://docs.microsoft.com/azure/cognitive-services/custom-vision-service/quickstarts/object-detection?tabs=visual-studio&WT.mc_id=academic-77998-cacaste)），但了解目标检测的工作原理并能够训练您自己的模型很重要。

