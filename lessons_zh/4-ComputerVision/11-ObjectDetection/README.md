# 目标检测

到目前为止，我们处理的图像分类模型接受图像并产生分类结果，例如 MNIST 问题中的类别"数字"。然而，在许多情况下，我们不仅想知道图片描绘了对象 - 我们希望能够确定它们的精确位置。这正是**目标检测**的要点。

## [课前测验](https://ff-quizzes.netlify.app/en/ai/quiz/21)

![目标检测](images/Screen_Shot_2016-11-17_at_11.14.54_AM.png)

> 图片来自 [YOLO v2 网站](https://pjreddie.com/darknet/yolov2/)

## 目标检测的朴素方法

假设我们想在图片上找到一只猫，目标检测的一个非常朴素的方法如下：

1. 将图片分解为多个图块
2. 对每个图块运行图像分类。
3. 那些产生足够高激活的图块可以被认为包含所讨论的对象。

![朴素目标检测](images/naive-detection.png)

> *图片来自[练习笔记本](ObjectDetection-TF.ipynb)*

然而，这种方法远非理想，因为它只允许算法非常不精确地定位对象的边界框。为了更精确的位置，我们需要运行某种**回归**来预测边界框的坐标 - 为此，我们需要特定的数据集。

## 目标检测的回归

[这篇博客文章](https://towardsdatascience.com/object-detection-with-neural-networks-a4e2c46b4491) 对检测形状有一个很好的温和介绍。

## 目标检测的数据集

您可能会遇到以下数据集用于此任务：

* [PASCAL VOC](http://host.robots.ox.ac.uk/pascal/VOC/) - 20 个类别
* [COCO](http://cocodataset.org/#home) - 上下文中的常见对象。80 个类别，边界框和分割掩码

![COCO](images/coco-examples.jpg)

## 目标检测指标

### 交并比

虽然对于图像分类很容易衡量算法的表现如何，但对于目标检测，我们需要衡量类别的正确性以及推断的边界框位置的精度。对于后者，我们使用所谓的**交并比**（IoU），它衡量两个框（或两个任意区域）的重叠程度。

![IoU](images/iou_equation.png)

> *图 2 来自[这篇关于 IoU 的优秀博客文章](https://pyimagesearch.com/2016/11/07/intersection-over-union-iou-for-object-detection/)*

这个想法很简单 - 我们将两个图形之间的交集面积除以它们的并集面积。对于两个相同的区域，IoU 将是 1，而对于完全不相交的区域，它将是 0。否则它将在 0 到 1 之间变化。我们通常只考虑 IoU 超过某个值的边界框。

### 平均精度

假设我们想衡量给定对象类别 $C$ 的识别程度。为了衡量它，我们使用**平均精度**指标，计算如下：

1. 考虑精确率-召回率曲线显示取决于检测阈值值（从 0 到 1）的准确率。
2. 根据阈值，我们将在图像中检测到或多或少的目标，以及不同的精确率和召回率值。
3. 曲线将如下所示：

<img src="https://github.com/shwars/NeuroWorkshop/raw/master/images/ObjDetectionPrecisionRecall.png"/>

> *图片来自 [NeuroWorkshop](http://github.com/shwars/NeuroWorkshop)*

给定类别 $C$ 的平均精度是此曲线下的面积。更准确地说，召回轴通常分为 10 部分，精确率在所有这些点上平均：

$$
AP = {1\over11}\sum_{i=0}^{10}\mbox{Precision}(\mbox{Recall}={i\over10})
$$

### AP 和 IoU

我们只考虑那些检测，其中 IoU 超过某个值。例如，在 PASCAL VOC 数据集中，通常假设 $\mbox{IoU Threshold} = 0.5$，而在 COCO 中，AP 是针对 $\mbox{IoU Threshold}$ 的不同值测量的。

<img src="https://github.com/shwars/NeuroWorkshop/raw/master/images/ObjDetectionPrecisionRecallIoU.png"/>

> *图片来自 [NeuroWorkshop](http://github.com/shwars/NeuroWorkshop)*

### 平均精度均值 - mAP

目标检测的主要指标称为**平均精度均值**，或**mAP**。它是平均精度的值，在所有对象类别上平均，有时也在 $\mbox{IoU Threshold}$ 上平均。更详细地，计算 **mAP** 的过程在[这篇博客文章](https://medium.com/@timothycarlen/understanding-the-map-evaluation-metric-for-object-detection-a07fe6962cf3))中描述，也在[这里使用代码示例](https://gist.github.com/tarlen5/008809c3decf19313de216b9208f3734)。

## 不同的目标检测方法

目标检测算法有两个大类：

* **区域提议网络**（R-CNN、Fast R-CNN、Faster R-CNN）。主要思想是生成**感兴趣区域**（ROI）并在它们上运行 CNN，寻找最大激活。它与朴素方法有点相似，除了 ROI 是以更聪明的方式生成的。这种方法的主要缺点之一是它们很慢，因为我们需要在图像上多次通过 CNN 分类器。
* **单次**（YOLO、SSD、RetinaNet）方法。在这些架构中，我们设计网络以在一次通过中预测类别和 ROI。

### R-CNN：基于区域的 CNN

[R-CNN](http://islab.ulsan.ac.kr/files/announcement/513/rcnn_pami.pdf) 使用[选择性搜索](http://www.huppelen.nl/publications/selectiveSearchDraft.pdf)生成 ROI 区域的分层结构，然后通过 CNN 特征提取器和 SVM 分类器来确定对象类别，并使用线性回归来确定*边界框*坐标。[官方论文](https://arxiv.org/pdf/1506.01497v1.pdf)

![RCNN](images/rcnn1.png)

> *图片来自 van de Sande et al. ICCV'11*

![RCNN-1](images/rcnn2.png)

> *图片来自[这篇博客](https://towardsdatascience.com/r-cnn-fast-r-cnn-faster-r-cnn-yolo-object-detection-algorithms-36d53571365e)

### F-RCNN - Fast R-CNN

这种方法类似于 R-CNN，但在应用卷积层之后定义区域。

![FRCNN](images/f-rcnn.png)

> 图片来自[官方论文](https://www.cv-foundation.org/openaccess/content_iccv_2015/papers/Girshick_Fast_R-CNN_ICCV_2015_paper.pdf)，[arXiv](https://arxiv.org/pdf/1504.08083.pdf)，2015

### Faster R-CNN

这种方法的主要思想是使用神经网络来预测 ROI - 所谓的*区域提议网络*。[论文](https://arxiv.org/pdf/1506.01497.pdf)，2016

![FasterRCNN](images/faster-rcnn.png)

> 图片来自[官方论文](https://arxiv.org/pdf/1506.01497.pdf)

### R-FCN：基于区域的全卷积网络

该算法甚至比 Faster R-CNN 更快。主要思想如下：

1. 我们使用 ResNet-101 提取特征
1. 特征由**位置敏感分数图**处理。来自 $C$ 类的每个对象被 $k\times k$ 区域划分，我们训练以预测对象的部分。
1. 对于来自 $k\times k$ 区域的每个部分，所有网络对对象类别进行投票，并选择具有最大投票的对象类别。

![r-fcn image](images/r-fcn.png)

> 图片来自[官方论文](https://arxiv.org/abs/1605.06409)

### YOLO - You Only Look Once

YOLO 是一个实时单次算法。主要思想如下：

 * 图像被分为 $S\times S$ 区域
 * 对于每个区域，**CNN** 预测 $n$ 个可能的目标、*边界框*坐标和*置信度*=*概率* * IoU。

 ![YOLO](images/yolo.png)

> 图片来自[官方论文](https://arxiv.org/abs/1506.02640)

### 其他算法

* RetinaNet：[官方论文](https://arxiv.org/abs/1708.02002)
   - [Torchvision 中的 PyTorch 实现](https://pytorch.org/vision/stable/_modules/torchvision/models/detection/retinanet.html)
   - [Keras 实现](https://github.com/fizyr/keras-retinanet)
   - [使用 RetinaNet 进行目标检测](https://keras.io/examples/vision/retinanet/) 在 Keras 示例中
* SSD（单次检测器）：[官方论文](https://arxiv.org/abs/1512.02325)

## ✍️ 练习：目标检测

在以下笔记本中继续学习：

[ObjectDetection.ipynb](ObjectDetection.ipynb)

## 结论

在本课中，您快速浏览了可以完成目标检测的所有各种方式！

## 🚀 挑战

阅读这些关于 YOLO 的文章和笔记本，并亲自尝试它们

* [描述 YOLO 的优秀博客文章](https://www.analyticsvidhya.com/blog/2018/12/practical-guide-object-detection-yolo-framewor-python/)
 * [官方网站](https://pjreddie.com/darknet/yolo/)
 * Yolo：[Keras 实现](https://github.com/experiencor/keras-yolo2)，[逐步笔记本](https://github.com/experiencor/basic-yolo-keras/blob/master/Yolo%20Step-by-Step.ipynb)
 * Yolo v2：[Keras 实现](https://github.com/experiencor/keras-yolo2)，[逐步笔记本](https://github.com/experiencor/keras-yolo2/blob/master/Yolo%20Step-by-Step.ipynb)

## [课后测验](https://ff-quizzes.netlify.app/en/ai/quiz/22)

## 复习与自主学习

* [目标检测](https://tjmachinelearning.com/lectures/1718/obj/) 由 Nikhil Sardana
* [目标检测算法的良好比较](https://lilianweng.github.io/lil-log/2018/12/27/object-detection-part-4.html)
* [目标检测深度学习算法回顾](https://medium.com/comet-app/review-of-deep-learning-algorithms-for-object-detection-c1f3d437b852)
* [基本目标检测算法的逐步介绍](https://www.analyticsvidhya.com/blog/2018/10/a-step-by-step-introduction-to-the-basic-object-detection-algorithms-part-1/)
* [在 Python 中实现 Faster R-CNN 进行目标检测](https://www.analyticsvidhya.com/blog/2018/11/implementation-faster-r-cnn-python-object-detection/)

## [作业：目标检测](lab/README.md)

