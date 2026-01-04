# 如何运行代码

本课程包含大量可执行的示例和实验，您可能想要运行它们。为了做到这一点，您需要能够执行本课程中提供的 Jupyter Notebook 中的 Python 代码。您有几种运行代码的选项：

## 在本地计算机上运行

要在本地计算机上运行代码，您需要安装某个版本的 Python。我个人建议安装 **[miniconda](https://conda.io/en/latest/miniconda.html)** - 这是一个相当轻量级的安装，支持用于不同 Python **虚拟环境**的 `conda` 包管理器。

安装 miniconda 后，您需要克隆仓库并创建一个用于本课程的虚拟环境：

```bash
git clone http://github.com/microsoft/ai-for-beginners
cd ai-for-beginners
conda env create --name ai4beg --file .devcontainer/environment.yml
conda activate ai4beg
```

### 使用 Visual Studio Code 和 Python 扩展

使用本课程的最佳方式可能是在 [Visual Studio Code](http://code.visualstudio.com/?WT.mc_id=academic-77998-cacaste) 中使用 [Python 扩展](https://marketplace.visualstudio.com/items?itemName=ms-python.python&WT.mc_id=academic-77998-cacaste)打开它。

> **注意**：一旦您在 VS Code 中克隆并打开目录，它会自动建议您安装 Python 扩展。您还需要按照上述说明安装 miniconda。

> **注意**：如果 VS Code 建议您在容器中重新打开仓库，您需要拒绝此操作以使用本地 Python 安装。

### 在浏览器中使用 Jupyter

您也可以直接在浏览器中使用 Jupyter 环境。实际上，经典的 Jupyter 和 Jupyter Hub 都提供了非常方便的开发环境，具有自动完成、代码高亮等功能。

要在本地启动 Jupyter，请进入课程目录，然后执行：

```bash
jupyter notebook
```
或
```bash
jupyterhub
```
然后您可以导航到任何 `.ipynb` 文件，打开它们并开始工作。

### 在容器中运行

Python 安装的另一种选择是在容器中运行代码。由于我们的仓库包含特殊的 `.devcontainer` 文件夹，该文件夹指示如何为此仓库构建容器，VS Code 会建议您在容器中重新打开代码。这需要 Docker 安装，也会更复杂，因此我们建议更有经验的用户使用此方法。

## 在云中运行

如果您不想在本地安装 Python，并且可以访问一些云资源 - 一个很好的替代方法是在云中运行代码。有几种方法可以做到这一点：

* 使用 **[GitHub Codespaces](https://github.com/features/codespaces)**，这是 GitHub 为您创建的虚拟环境，可通过 VS Code 浏览器界面访问。如果您可以访问 Codespaces，只需点击仓库中的 **Code** 按钮，启动 codespace，即可立即开始运行。
* 使用 **[Binder](https://mybinder.org/v2/gh/microsoft/ai-for-beginners/HEAD)**。[Binder](https://mybinder.org) 是在云中提供的免费计算资源，供像您这样的人在 GitHub 上测试一些代码。首页有一个按钮可以在 Binder 中打开仓库 - 这应该会快速带您到 binder 站点，它将为您无缝构建底层容器并启动 Jupyter Web 界面。

> **注意**：为了防止滥用，Binder 阻止了对某些 Web 资源的访问。这可能会阻止某些代码工作，这些代码从公共互联网获取模型和/或数据集。您可能需要找到一些解决方法。此外，Binder 提供的计算资源相当基础，因此训练会很慢，尤其是在后面更复杂的课程中。

## 在云中使用 GPU 运行

本课程中的一些后续课程将大大受益于 GPU 支持，因为否则训练会非常慢。您可以遵循几个选项，特别是如果您通过 [Azure for Students](https://azure.microsoft.com/free/students/?WT.mc_id=academic-77998-cacaste) 或通过您的机构访问云：

* 创建[数据科学虚拟机](https://docs.microsoft.com/learn/modules/intro-to-azure-data-science-virtual-machine/?WT.mc_id=academic-77998-cacaste)并通过 Jupyter 连接到它。然后您可以将仓库直接克隆到机器上，并开始学习。NC 系列 VM 支持 GPU。

> **注意**：某些订阅（包括 Azure for Students）默认不提供 GPU 支持。您可能需要通过技术支持请求请求额外的 GPU 核心。

* 创建 [Azure Machine Learning 工作区](https://azure.microsoft.com/services/machine-learning/?WT.mc_id=academic-77998-cacaste)，然后使用其中的 Notebook 功能。[此视频](https://azure-for-academics.github.io/quickstart/azureml-papers/)展示了如何将仓库克隆到 Azure ML notebook 并开始使用它。

您也可以使用 Google Colab，它提供一些免费的 GPU 支持，并在那里上传 Jupyter Notebooks 以逐个执行它们。

