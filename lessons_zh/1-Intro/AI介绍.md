# 📖 AI 介绍

<div style="text-align: center; margin: 40px 0;">
  <img src="/lessons_zh/ai-intro-zh.png" alt="AI 介绍内容摘要" style="max-width: 100%; height: auto; border-radius: 12px; box-shadow: 0 8px 24px rgba(0,0,0,0.1); animation: fadeInUp 1s ease-out;">
</div>

---

## [课前测验](https://ff-quizzes.netlify.app/en/ai/quiz/1)

<div style="background: linear-gradient(135deg, rgba(37, 99, 235, 0.05) 0%, rgba(124, 58, 237, 0.05) 100%); padding: 25px; border-radius: 12px; margin: 30px 0; border-left: 4px solid #2563eb;">

**人工智能**是一门令人兴奋的科学学科，研究如何让计算机表现出智能行为，例如做那些人类擅长做的事情。

最初，计算机是由 [Charles Babbage](https://en.wikipedia.org/wiki/Charles_Babbage) 发明的，用于按照明确定义的程序（算法）对数字进行操作。现代计算机，尽管比 19 世纪提出的原始模型先进得多，但仍然遵循相同的受控计算思想。因此，如果我们知道实现目标所需的确切步骤序列，就可以对计算机进行编程以执行某些操作。

</div>

![人物照片](images/dsh_age.png)

> 照片由 [Vickie Soshnikova](http://twitter.com/vickievalerie) 拍摄

> ✅ 从照片中确定一个人的年龄是一项无法明确编程的任务，因为我们不知道当我们这样做时，我们是如何在脑海中得出一个数字的。

---

然而，有些任务我们不知道如何明确解决。考虑从照片中确定一个人的年龄。我们以某种方式学会这样做，因为我们见过许多不同年龄的人的例子，但我们无法明确解释我们是如何做到的，也无法对计算机进行编程来做到这一点。这正是**人工智能**（简称 AI）感兴趣的任务类型。

✅ 思考一些您可以交给计算机的任务，这些任务将受益于 AI。考虑金融、医学和艺术领域 - 这些领域今天如何从 AI 中受益？

---

## 弱 AI 与强 AI

<div style="overflow-x: auto; margin: 30px 0;">

| 弱 AI | 强 AI |
|-------|-------|
| 弱 AI 是指为特定任务或狭窄任务集设计和训练的 AI 系统。 | 强 AI，或人工通用智能（AGI），是指具有人类水平智能和理解能力的 AI 系统。 |
| 这些 AI 系统通常不是智能的；它们在执行预定义任务方面表现出色，但缺乏真正的理解或意识。 | 这些 AI 系统能够执行人类可以执行的任何智力任务，适应不同领域，并拥有某种形式的意识或自我意识。 |
| 弱 AI 的例子包括像 Siri 或 Alexa 这样的虚拟助手、流媒体服务使用的推荐算法，以及为特定客户服务任务设计的聊天机器人。 | 实现强 AI 是 AI 研究的长期目标，需要开发能够在广泛的任务和环境中进行推理、学习、理解和适应的 AI 系统。 |
| 弱 AI 高度专业化，不具备类似人类的认知能力或超出其狭窄领域的一般问题解决能力。 | 强 AI 目前是一个理论概念，还没有 AI 系统达到这种通用智能水平。 |

</div>

更多信息请参考 **[人工通用智能](https://en.wikipedia.org/wiki/Artificial_general_intelligence)**（AGI）。

---

## 智能的定义和图灵测试

处理 **[智能](https://en.wikipedia.org/wiki/Intelligence)** 这个术语时的一个问题是，这个术语没有明确的定义。人们可以争辩说智能与**抽象思维**或**自我意识**有关，但我们无法正确定义它。

![猫的照片](images/photo-cat.jpg)

> [照片](https://unsplash.com/photos/75715CVEJhI) 由 [Amber Kipp](https://unsplash.com/@sadmax) 在 Unsplash 上拍摄

要看到*智能*这个术语的模糊性，请尝试回答一个问题："猫是智能的吗？"。不同的人倾向于对这个问题给出不同的答案，因为没有普遍接受的测试来证明这个断言是真是假。如果您认为有 - 请尝试让您的猫通过 IQ 测试...

✅ 思考一分钟，您如何定义智能。能够解决迷宫并获得食物的乌鸦是智能的吗？孩子是智能的吗？

---

当谈到 AGI 时，我们需要某种方式来判断我们是否创建了真正智能的系统。[Alan Turing](https://en.wikipedia.org/wiki/Alan_Turing) 提出了一种称为 **[图灵测试](https://en.wikipedia.org/wiki/Turing_test)** 的方法，它也像智能的定义一样。该测试将给定系统与本质上智能的东西 - 真实的人类进行比较，并且因为任何自动比较都可以被计算机程序绕过，我们使用人类询问者。因此，如果人类无法在基于文本的对话中区分真实的人和计算机系统 - 该系统被认为是智能的。

> 一个名为 [Eugene Goostman](https://en.wikipedia.org/wiki/Eugene_Goostman) 的聊天机器人，在圣彼得堡开发，在 2014 年通过使用巧妙的个性技巧接近通过图灵测试。它提前宣布自己是一个 13 岁的乌克兰男孩，这将解释知识的缺乏和文本中的一些差异。该机器人在 5 分钟的对话后说服了 30% 的法官它是人类，这是图灵认为机器到 2000 年能够通过的指标。然而，应该理解的是，这并不表明我们已经创建了一个智能系统，或者计算机系统欺骗了人类询问者 - 系统没有欺骗人类，而是机器人创建者做到了！

✅ 您是否曾经被聊天机器人欺骗，认为您正在与人类交谈？它是如何说服您的？

---

## AI 的不同方法

如果我们想让计算机表现得像人类一样，我们需要以某种方式在计算机内模拟我们的思维方式。因此，我们需要尝试理解是什么使人类变得智能。

> 为了能够将智能编程到机器中，我们需要了解我们自己的决策过程是如何工作的。如果您做一些自我反省，您会意识到有些过程是下意识发生的 - 例如，我们可以在不思考的情况下区分猫和狗 - 而其他一些涉及推理。

有两种可能的方法来解决这个问题：

<div style="overflow-x: auto; margin: 30px 0;">

| 自上而下方法（符号推理） | 自下而上方法（神经网络） |
|------------------------|------------------------|
| 自上而下的方法模拟一个人解决问题时的推理方式。它涉及从人类中提取**知识**，并以计算机可读的形式表示它。我们还需要开发一种方法来在计算机内模拟**推理**。 | 自下而上的方法模拟人脑的结构，由大量称为**神经元**的简单单元组成。每个神经元就像其输入的加权平均值，我们可以通过提供**训练数据**来训练神经元网络以解决有用的问题。 |

</div>

还有一些其他可能的智能方法：

* **涌现**、**协同**或**多智能体方法**基于这样一个事实：复杂的智能行为可以通过大量简单智能体的交互获得。根据[进化控制论](https://en.wikipedia.org/wiki/Global_brain#Evolutionary_cybernetics)，智能可以从更简单的反应行为中*涌现*，在*元系统转换*过程中。

* **进化方法**或**遗传算法**是基于进化原理的优化过程。

我们将在课程后面考虑这些方法，但现在我们将专注于两个主要方向：自上而下和自下而上。

### 自上而下方法

在**自上而下方法**中，我们尝试模拟我们的推理。因为当我们推理时我们可以跟随我们的思想，我们可以尝试形式化这个过程并在计算机内编程它。这称为**符号推理**。

人们倾向于在头脑中有一些指导其决策过程的规则。例如，当医生诊断患者时，他或她可能意识到一个人发烧，因此体内可能有一些炎症。通过将大量规则应用于特定问题，医生可能能够得出最终诊断。

这种方法严重依赖于**知识表示**和**推理**。从人类专家中提取知识可能是最困难的部分，因为医生在许多情况下不知道他或她为什么会得出特定诊断。有时解决方案只是在他或她的脑海中出现，而没有明确的思考。某些任务，例如从照片中确定一个人的年龄，根本无法简化为操作知识。

### 自下而上方法

或者，我们可以尝试模拟大脑中最简单的元素 - 神经元。我们可以在计算机内构建所谓的**人工神经网络**，然后尝试通过给它示例来教它解决问题。这个过程类似于新生儿如何通过观察了解他或她周围的环境。

✅ 做一些关于婴儿如何学习的研究。婴儿大脑的基本元素是什么？

<div style="background: #f8f9fa; padding: 20px; border-radius: 8px; margin: 20px 0; border-left: 4px solid #06b6d4;">

| 关于机器学习呢？         |      |
|--------------|-----------|
| 基于计算机学习根据某些数据解决问题的部分人工智能称为**机器学习**。我们不会在本课程中考虑经典机器学习 - 我们向您推荐单独的 [机器学习初学者](http://aka.ms/ml-beginners) 课程。 |   ![机器学习初学者](images/ml-for-beginners.png)    |

</div>

---

## AI 简史

人工智能作为一门学科在 20 世纪中叶开始。最初，符号推理是一种流行的方法，它导致了许多重要的成功，例如专家系统 - 能够在某些有限问题领域充当专家的计算机程序。然而，很快就清楚这种方法不能很好地扩展。从专家中提取知识，在计算机中表示它，并保持该知识库的准确性，结果证明是一项非常复杂的任务，在许多情况下太昂贵而不实用。这导致了 20 世纪 70 年代的所谓 [AI 寒冬](https://en.wikipedia.org/wiki/AI_winter)。

<img alt="AI 简史" src="images/history-of-ai.png" style="width: 70%; max-width: 100%; display: block; margin: 30px auto; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1);"/>

> 图片由 [Dmitry Soshnikov](http://soshnikov.com) 制作

随着时间的推移，计算资源变得更便宜，更多数据变得可用，因此神经网络方法开始在许多领域（如计算机视觉或语音理解）与人类竞争方面表现出色。在过去十年中，人工智能这个术语主要被用作神经网络的同义词，因为我们听到的大多数 AI 成功都基于它们。

我们可以观察到方法的变化，例如，在创建下棋计算机程序时：

* 早期的国际象棋程序基于搜索 - 程序明确尝试估计对手在给定数量的下一步移动中的可能移动，并根据可以在几步内实现的最佳位置选择最佳移动。这导致了所谓的 [alpha-beta 剪枝](https://en.wikipedia.org/wiki/Alpha%E2%80%93beta_pruning) 搜索算法的发展。
* 搜索策略在游戏结束时效果很好，搜索空间受到少量可能移动的限制。然而，在游戏开始时，搜索空间是巨大的，可以通过从人类玩家之间的现有对局中学习来改进算法。随后的实验采用了所谓的 [基于案例的推理](https://en.wikipedia.org/wiki/Case-based_reasoning)，程序在知识库中查找与游戏中当前位置非常相似的案例。
* 战胜人类玩家的现代程序基于神经网络和[强化学习](https://en.wikipedia.org/wiki/Reinforcement_learning)，程序通过长时间与自己对抗并从自己的错误中学习来学习下棋 - 就像人类学习下棋时一样。然而，计算机程序可以在更短的时间内玩更多的游戏，因此可以学习得更快。

✅ 做一些关于其他由 AI 玩的游戏的研究。

类似地，我们可以看到创建"对话程序"（可能通过图灵测试）的方法如何变化：

* 这种类型的早期程序，如 [Eliza](https://en.wikipedia.org/wiki/ELIZA)，基于非常简单的语法规则和将输入句子重新表述为问题。
* 现代助手，如 Cortana、Siri 或 Google Assistant，都是混合系统，使用神经网络将语音转换为文本并识别我们的意图，然后采用一些推理或显式算法来执行所需的操作。
* 在未来，我们可能期望一个完全基于神经的模型自己处理对话。最近的 GPT 和 [Turing-NLG](https://www.microsoft.com/research/blog/turing-nlg-a-17-billion-parameter-language-model-by-microsoft) 神经网络家族在这方面表现出色。

<img alt="图灵测试的演变" src="images/turing-test-evol.png" style="width: 70%; max-width: 100%; display: block; margin: 30px auto; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1);"/>

> 图片由 Dmitry Soshnikov 制作，[照片](https://unsplash.com/photos/r8LmVbUKgns) 由 [Marina Abrosimova](https://unsplash.com/@abrosimova_marina_foto) 在 Unsplash 上拍摄

---

## 最近的 AI 研究

神经网络研究的巨大增长大约从 2010 年开始，当时大型公共数据集开始变得可用。一个名为 [ImageNet](https://en.wikipedia.org/wiki/ImageNet) 的巨大图像集合，包含约 1400 万张带注释的图像，催生了 [ImageNet 大规模视觉识别挑战](https://image-net.org/challenges/LSVRC/)。

![ILSVRC 准确率](images/ilsvrc.gif)

> 图片由 [Dmitry Soshnikov](http://soshnikov.com) 制作

2012 年，[卷积神经网络](../4-ComputerVision/07-ConvNets/README.md)首次用于图像分类，这导致分类错误显著下降（从近 30% 降至 16.4%）。2015 年，来自 Microsoft Research 的 ResNet 架构[达到了人类水平的准确率](https://doi.org/10.1109/ICCV.2015.123)。

从那时起，神经网络在许多任务中表现出非常成功的行为：

<div style="overflow-x: auto; margin: 30px 0;">

| 年份 | 达到人类水平 |
|-----|--------|
| 2015 | [图像分类](https://doi.org/10.1109/ICCV.2015.123) |
| 2016 | [对话语音识别](https://arxiv.org/abs/1610.05256) |
| 2018 | [自动机器翻译](https://arxiv.org/abs/1803.05567)（中文到英文） |
| 2020 | [图像字幕](https://arxiv.org/abs/2009.13682) |

</div>

在过去几年中，我们见证了大型语言模型的巨大成功，如 BERT 和 GPT-3。这主要是由于有大量通用文本数据可用，使我们能够训练模型以捕获文本的结构和含义，在通用文本集合上对它们进行预训练，然后将这些模型专门用于更具体的任务。我们将在本课程后面了解更多关于[自然语言处理](../5-NLP/README.md)的内容。

---

## 🚀 挑战

在互联网上进行一次巡游，以确定在您看来，AI 在哪里最有效地使用。是在地图应用中，还是在某些语音转文本服务或视频游戏中？研究该系统是如何构建的。

---

## [课后测验](https://ff-quizzes.netlify.app/en/ai/quiz/2)

---

## 复习与自主学习

通过阅读[这节课](https://github.com/microsoft/ML-For-Beginners/tree/main/1-Introduction/2-history-of-ML)来复习 AI 和 ML 的历史。从该课程或本课程顶部的思维导图中选择一个元素，并更深入地研究它以了解其演变的文化背景。

**作业**：[游戏开发](assignment.md)

---

<div style="text-align: center; margin: 50px 0;">
  <a href="/lessons_zh/README.md" style="display: inline-block; padding: 15px 40px; background: linear-gradient(135deg, #2563eb 0%, #7c3aed 100%); color: white; text-decoration: none; border-radius: 8px; font-weight: 600; font-size: 1.1em; box-shadow: 0 4px 12px rgba(37, 99, 235, 0.4); transition: all 0.3s;">
    🏠 返回首页
  </a>
</div>

<style>
@keyframes fadeInUp {
  from {
    opacity: 0;
    transform: translateY(30px);
  }
  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>

