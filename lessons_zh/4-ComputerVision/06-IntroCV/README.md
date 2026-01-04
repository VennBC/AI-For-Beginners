# 计算机视觉介绍

[计算机视觉](https://wikipedia.org/wiki/Computer_vision)是一门学科，其目标是让计算机获得对数字图像的高级理解。这是一个相当广泛的定义，因为*理解*可能意味着许多不同的事情，包括在图片上找到对象（**目标检测**）、理解正在发生的事情（**事件检测**）、用文本描述图片，或在 3D 中重建场景。还有一些与人类图像相关的特殊任务：年龄和情感估计、人脸检测和识别，以及 3D 姿态估计，仅举几例。

## [课前测验](https://ff-quizzes.netlify.app/en/ai/quiz/11)

计算机视觉最简单的任务之一是**图像分类**。

计算机视觉通常被认为是 AI 的一个分支。如今，大多数计算机视觉任务都使用神经网络解决。我们将在本节中了解更多关于用于计算机视觉的特殊类型的神经网络，[卷积神经网络](../07-ConvNets/README.md)。

但是，在将图像传递给神经网络之前，在许多情况下，使用一些算法技术来增强图像是有意义的。

有几个可用的 Python 库用于图像处理：

* **[imageio](https://imageio.readthedocs.io/en/stable/)** 可用于读取/写入不同的图像格式。它还支持 ffmpeg，这是一个将视频帧转换为图像的有用工具。
* **[Pillow](https://pillow.readthedocs.io/en/stable/index.html)**（也称为 PIL）功能更强大，还支持一些图像操作，如变形、调色板调整等。
* **[OpenCV](https://opencv.org/)** 是一个用 C++ 编写的强大图像处理库，已成为图像处理的*事实*标准。它有一个方便的 Python 接口。
* **[dlib](http://dlib.net/)** 是一个 C++ 库，实现了许多机器学习算法，包括一些计算机视觉算法。它也有一个 Python 接口，可用于具有挑战性的任务，如人脸和面部标志检测。

## OpenCV

[OpenCV](https://opencv.org/) 被认为是图像处理的*事实*标准。它包含许多有用的算法，用 C++ 实现。您也可以从 Python 调用 OpenCV。

学习 OpenCV 的好地方是[这个 Learn OpenCV 课程](https://learnopencv.com/getting-started-with-opencv/)。在我们的课程中，我们的目标不是学习 OpenCV，而是向您展示一些可以使用它的示例，以及如何使用。

### 加载图像

Python 中的图像可以方便地用 NumPy 数组表示。例如，大小为 320x200 像素的灰度图像将存储在 200x320 数组中，相同尺寸的彩色图像将具有 200x320x3 的形状（对于 3 个颜色通道）。要加载图像，您可以使用以下代码：

```python
import cv2
import matplotlib.pyplot as plt

im = cv2.imread('image.jpeg')
plt.imshow(im)
```

传统上，OpenCV 对彩色图像使用 BGR（蓝-绿-红）编码，而其他 Python 工具使用更传统的 RGB（红-绿-蓝）。为了使图像看起来正确，您需要将其转换为 RGB 颜色空间，可以通过交换 NumPy 数组中的维度，或通过调用 OpenCV 函数：

```python
im = cv2.cvtColor(im,cv2.COLOR_BGR2RGB)
```

相同的 `cvtColor` 函数可用于执行其他颜色空间转换，例如将图像转换为灰度或 HSV（色调-饱和度-值）颜色空间。

您也可以使用 OpenCV 逐帧加载视频 - 在练习 [OpenCV 笔记本](OpenCV.ipynb) 中给出了一个示例。

### 图像处理

在将图像输入神经网络之前，您可能希望应用几个预处理步骤。OpenCV 可以做很多事情，包括：

* 使用 `im = cv2.resize(im, (320,200),interpolation=cv2.INTER_LANCZOS)` **调整图像大小**
* 使用 `im = cv2.medianBlur(im,3)` 或 `im = cv2.GaussianBlur(im, (3,3), 0)` **模糊**图像
* 更改图像的**亮度和对比度**可以通过 NumPy 数组操作来完成，如[此 Stackoverflow 注释](https://stackoverflow.com/questions/39308030/how-do-i-increase-the-contrast-of-an-image-in-python-opencv)中所述。
* 通过调用 `cv2.threshold`/`cv2.adaptiveThreshold` 函数使用[阈值化](https://docs.opencv.org/4.x/d7/d4d/tutorial_py_thresholding.html)，这通常比调整亮度或对比度更可取。
* 对图像应用不同的[变换](https://docs.opencv.org/4.5.5/da/d6e/tutorial_py_geometric_transformations.html)：
    - **[仿射变换](https://docs.opencv.org/4.5.5/d4/d61/tutorial_warp_affine.html)** 如果您需要将旋转、调整大小和倾斜组合到图像中，并且您知道图像中三个点的源和目标位置，则很有用。仿射变换保持平行线平行。
    - **[透视变换](https://medium.com/analytics-vidhya/opencv-perspective-transformation-9edffefb2143)** 当您知道图像中 4 个点的源和目标位置时很有用。例如，如果您通过智能手机相机从某个角度拍摄矩形文档的照片，并且您想制作文档本身的矩形图像。
* 通过使用**[光流](https://docs.opencv.org/4.5.5/d4/dee/tutorial_optical_flow.html)**来理解图像内的运动。

## 使用计算机视觉的示例

在我们的 [OpenCV 笔记本](OpenCV.ipynb)中，我们给出了一些示例，说明何时可以使用计算机视觉来执行特定任务：

* **预处理盲文书籍的照片**。我们专注于如何使用阈值化、特征检测、透视变换和 NumPy 操作来分离单个盲文符号，以便由神经网络进一步分类。

![盲文图像](data/braille.jpeg) | ![盲文图像预处理](images/braille-result.png) | ![盲文符号](images/braille-symbols.png)
----|-----|-----

> 图片来自 [OpenCV.ipynb](OpenCV.ipynb)

* **使用帧差检测视频中的运动**。如果相机是固定的，那么来自相机馈送的帧应该彼此非常相似。由于帧表示为数组，只需减去两个后续帧的那些数组，我们将得到像素差，对于静态帧应该很低，一旦图像中有大量运动就会变得更高。

![视频帧和帧差的图像](images/frame-difference.png)

> 图片来自 [OpenCV.ipynb](OpenCV.ipynb)

* **使用光流检测运动**。[光流](https://docs.opencv.org/3.4/d4/dee/tutorial_optical_flow.html) 允许我们理解视频帧上的单个像素如何移动。有两种类型的光流：

   - **密集光流**计算向量场，显示每个像素的移动位置
   - **稀疏光流**基于在图像中获取一些独特特征（例如边缘），并构建它们从帧到帧的轨迹。

![光流图像](images/optical.png)

> 图片来自 [OpenCV.ipynb](OpenCV.ipynb)

## ✍️ 示例笔记本：OpenCV [尝试 OpenCV 的实际应用](OpenCV.ipynb)

让我们通过探索 [OpenCV 笔记本](OpenCV.ipynb) 来进行一些 OpenCV 实验

## 结论

有时，相对复杂的任务，如运动检测或指尖检测，可以纯粹通过计算机视觉来解决。因此，了解计算机视觉的基本技术以及像 OpenCV 这样的库可以做什么是非常有帮助的。

## 🚀 挑战

观看 [此视频](https://docs.microsoft.com/shows/ai-show/ai-show--2021-opencv-ai-competition--grand-prize-winners--cortic-tigers--episode-32?WT.mc_id=academic-77998-cacaste) 来自 AI 节目，了解 Cortic Tigers 项目以及他们如何构建基于块的解决方案，通过机器人来民主化计算机视觉任务。对类似的其他项目进行一些研究，这些项目帮助新学习者进入该领域。

## [课后测验](https://ff-quizzes.netlify.app/en/ai/quiz/12)

## 复习与自主学习

在[这个很棒的教程](https://learnopencv.com/optical-flow-in-opencv/)中阅读更多关于光流的内容。

## [作业](lab/README.md)

在这个实验中，您将拍摄一个带有简单手势的视频，您的目标是使用光流提取上/下/左/右运动。

<img src="images/palm-movement.png" width="30%" alt="手掌运动帧"/>

