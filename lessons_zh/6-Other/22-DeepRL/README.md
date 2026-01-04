# 深度强化学习

强化学习（RL）被视为基本的机器学习范式之一，与监督学习和无监督学习并列。在监督学习中，我们依赖于已知结果的数据集，而 RL 基于**通过做来学习**。例如，当我们第一次看到计算机游戏时，我们开始玩，即使不知道规则，很快我们就能够通过玩游戏和调整行为的过程来提高我们的技能。

## [课前测验](https://ff-quizzes.netlify.app/en/ai/quiz/43)

要执行 RL，我们需要：

* 一个**环境**或**模拟器**，它设置游戏的规则。我们应该能够在模拟器中运行实验并观察结果。
* 一些**奖励函数**，它指示我们的实验有多成功。在学习玩计算机游戏的情况下，奖励将是我们的最终分数。

基于奖励函数，我们应该能够调整我们的行为并提高我们的技能，以便下次我们玩得更好。其他类型的机器学习和 RL 之间的主要区别在于，在 RL 中，我们通常不知道我们是赢还是输，直到我们完成游戏。因此，我们不能说某个单独的移动是好还是坏 - 我们只在游戏结束时收到奖励。

在 RL 期间，我们通常执行许多实验。在每个实验期间，我们需要在遵循我们到目前为止学到的最优策略（**利用**）和探索新的可能状态（**探索**）之间取得平衡。

## OpenAI Gym

RL 的一个很好的工具是 [OpenAI Gym](https://gym.openai.com/) - 一个**模拟环境**，可以模拟许多不同的环境，从 Atari 游戏到杆平衡背后的物理。它是训练强化学习算法最流行的模拟环境之一，由 [OpenAI](https://openai.com/) 维护。

> **注意**：您可以在[这里](https://gym.openai.com/envs/#classic_control)看到 OpenAI Gym 提供的所有环境。

## CartPole 平衡

您可能都见过现代平衡设备，如 *Segway* 或 *Gyroscooters*。它们能够通过响应来自加速度计或陀螺仪的信号来调整轮子来自动平衡。在本节中，我们将学习如何解决类似的问题 - 平衡杆。这类似于马戏团表演者需要在他手上平衡杆的情况 - 但这种杆平衡只发生在 1D 中。

平衡的简化版本称为 **CartPole** 问题。在 cartpole 世界中，我们有一个可以左右移动的水平滑块，目标是在滑块移动时在滑块顶部平衡垂直杆。

<img alt="cartpole" src="images/cartpole.png" width="200"/>

要创建和使用此环境，我们需要几行 Python 代码：

```python
import gym
env = gym.make("CartPole-v1")

env.reset()
done = False
total_reward = 0
while not done:
   env.render()
   action = env.action_space.sample()
   observaton, reward, done, info = env.step(action)
   total_reward += reward

print(f"Total reward: {total_reward}")
```

每个环境都可以完全相同的方式访问：
* `env.reset` 开始新实验
* `env.step` 执行模拟步骤。它从**动作空间**接收**动作**，并返回**观察**（来自观察空间），以及奖励和终止标志。

在上面的示例中，我们在每一步执行随机动作，这就是为什么实验寿命很短：

![不平衡的 cartpole](images/cartpole-nobalance.gif)

RL 算法的目标是训练一个模型 - 所谓的**策略** &pi; - 它将响应给定状态返回动作。我们也可以考虑策略是概率性的，例如，对于任何状态 *s* 和动作 *a*，它将返回概率 &pi;(*a*|*s*)，我们应该在状态 *s* 中采取 *a*。

## 策略梯度算法

建模策略的最明显方法是通过创建神经网络，该网络将状态作为输入，并返回相应的动作（或者更确切地说，所有动作的概率）。在某种意义上，它类似于正常的分类任务，主要区别 - 我们事先不知道在每一步应该采取哪些动作。

这里的想法是估计这些概率。我们构建一个**累积奖励**向量，显示我们在实验的每一步的总奖励。我们还通过将早期奖励乘以某个系数 &gamma;=0.99 来应用**奖励折扣**，以减弱早期奖励的作用。然后，我们加强实验路径中产生更大奖励的那些步骤。

> 在[示例笔记本](CartPole-RL-TF.ipynb)中了解更多关于策略梯度算法并查看它的实际应用。

## 演员-评论家算法

策略梯度方法的改进版本称为**演员-评论家**。它背后的主要思想是神经网络将被训练以返回两件事：

* 策略，它确定采取哪个动作。这部分称为**演员**
* 我们期望在此状态下获得的总奖励的估计 - 这部分称为**评论家**。

在某种意义上，这种架构类似于 [GAN](../../4-ComputerVision/10-GANs/README.md)，其中我们有两个相互对抗训练的网络。在演员-评论家模型中，演员提出我们需要采取的动作，评论家试图批评并估计结果。然而，我们的目标是统一训练这些网络。

因为我们知道真实的累积奖励和评论家在实验期间返回的结果，所以构建一个损失函数来最小化它们之间的差异相对容易。这将给我们**评论家损失**。我们可以使用与策略梯度算法中相同的方法计算**演员损失**。

运行这些算法之一后，我们可以期望我们的 CartPole 表现得像这样：

![平衡的 cartpole](images/cartpole-balance.gif)

## ✍️ 练习：策略梯度和演员-评论家 RL

在以下笔记本中继续学习：

* [TensorFlow 中的 RL](CartPole-RL-TF.ipynb)
* [PyTorch 中的 RL](CartPole-RL-PyTorch.ipynb)

## 其他 RL 任务

强化学习现在是快速发展的研究领域。强化学习的一些有趣例子是：

* 教计算机玩 **Atari 游戏**。这个问题中具有挑战性的部分是我们没有表示为向量的简单状态，而是屏幕截图 - 我们需要使用 CNN 将此屏幕图像转换为特征向量，或提取奖励信息。Atari 游戏在 Gym 中可用。
* 教计算机玩棋盘游戏，如国际象棋和围棋。最近，像 **Alpha Zero** 这样的最先进程序通过两个代理相互对抗并在每一步改进来从头训练。
* 在工业中，RL 用于从模拟创建控制系统。名为 [Bonsai](https://azure.microsoft.com/services/project-bonsai/?WT.mc_id=academic-77998-cacaste) 的服务专门为此设计。

## 结论

我们现在已经学会了如何训练代理通过为它们提供定义游戏期望状态的奖励函数，并通过给它们智能探索搜索空间的机会来获得良好的结果。我们成功尝试了两种算法，并在相对较短的时间内取得了良好的结果。然而，这只是您进入 RL 之旅的开始，如果您想深入了解，您绝对应该考虑参加单独的课程。

## 🚀 挑战

阅读这篇关于 RL 的精彩文章：[强化学习简介](https://www.analyticsvidhya.com/blog/2017/01/introduction-to-reinforcement-learning-implementation/)，并尝试在 Gym 中实现您自己的 RL 算法。

## [课后测验](https://ff-quizzes.netlify.app/en/ai/quiz/44)

## 复习与自主学习

* [强化学习简介](https://www.analyticsvidhya.com/blog/2017/01/introduction-to-reinforcement-learning-implementation/)
* [深度强化学习](https://www.analyticsvidhya.com/blog/2018/10/reinforcement-learning-introduction/) - 更深入的介绍

## [作业](lab/README.md)

在这个实验中，您将使用不同的 RL 算法训练 CartPole 平衡，并比较它们的性能。

