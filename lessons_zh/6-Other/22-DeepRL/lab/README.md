# 训练 Mountain Car 逃脱

来自 [AI 初学者课程](https://github.com/microsoft/ai-for-beginners) 的实验作业。

## 任务

您的目标是训练 RL 代理来控制 OpenAI 环境中的 [Mountain Car](https://www.gymlibrary.ml/environments/classic_control/mountain_car/)。

<img alt="Mountain Car" src="images/mountaincar.png" width="300"/>

## 环境

Mountain Car 环境由被困在山谷内的汽车组成。您的目标是跳出山谷并到达旗帜。您可以执行的动作是向左加速、向右加速或什么都不做。您可以观察汽车沿 x 轴的位置和速度。

## 起始笔记本

通过打开 [MountainCar.ipynb](MountainCar.ipynb) 开始实验

## 要点

您应该在整个实验中学到，将 RL 算法适应新环境通常非常简单，因为 OpenAI Gym 对所有环境都有相同的接口，并且算法本身在很大程度上不依赖于环境的性质。您甚至可以重构 Python 代码，以便将任何环境作为参数传递给 RL 算法。

