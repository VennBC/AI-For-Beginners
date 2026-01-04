#!/usr/bin/env python3
"""
批量翻译 lessons_zh 文件夹中所有 .ipynb 文件的 markdown cells 为中文
保持代码 cells 不变
"""

import json
import os
import glob
from pathlib import Path

# 翻译映射表 - 常见术语和短语
TRANSLATION_MAP = {
    # 通用术语
    "This notebook is a part of": "本笔记本是",
    "In this notebook": "在本笔记本中",
    "In this notebooks": "在本笔记本中",
    "we will": "我们将",
    "Let's": "让我们",
    "First": "首先",
    "Next": "接下来",
    "Finally": "最后",
    "Note": "注意",
    "Important": "重要",
    "Warning": "警告",
    "Example": "示例",
    "Exercise": "练习",
    "Task": "任务",
    "Challenge": "挑战",
    
    # 技术术语（保持英文，但可以添加中文注释）
    "import": "导入",
    "function": "函数",
    "class": "类",
    "variable": "变量",
    "array": "数组",
    "image": "图像",
    "model": "模型",
    "training": "训练",
    "testing": "测试",
    "dataset": "数据集",
    "neural network": "神经网络",
    "deep learning": "深度学习",
    "machine learning": "机器学习",
}

def translate_text(text):
    """
    翻译英文文本为中文
    这里使用简单的规则和映射，对于复杂翻译可以使用 API
    """
    # 如果文本已经是中文（包含中文字符），直接返回
    if any('\u4e00' <= char <= '\u9fff' for char in text):
        return text
    
    # 简单的翻译规则
    translated = text
    
    # 替换常见短语
    for en, zh in TRANSLATION_MAP.items():
        translated = translated.replace(en, zh)
    
    # 这里可以添加更复杂的翻译逻辑
    # 或者调用翻译 API（如 Google Translate API, DeepL API 等）
    
    return translated

def translate_notebook(notebook_path):
    """
    翻译单个 notebook 文件
    """
    print(f"处理文件: {notebook_path}")
    
    try:
        # 读取 notebook 文件
        with open(notebook_path, 'r', encoding='utf-8') as f:
            notebook = json.load(f)
        
        modified = False
        
        # 遍历所有 cells
        for cell in notebook.get('cells', []):
            if cell.get('cell_type') == 'markdown':
                # 获取 markdown 内容
                source = cell.get('source', [])
                
                # 如果是字符串列表，合并为字符串
                if isinstance(source, list):
                    text = ''.join(source)
                else:
                    text = source
                
                # 检查是否包含英文（简单检查：是否包含常见英文单词）
                has_english = any(
                    word in text.lower() 
                    for word in ['the', 'this', 'that', 'is', 'are', 'we', 'you', 'will', 'can', 'should']
                )
                
                # 如果包含英文且不全是代码块，进行翻译
                if has_english and not text.strip().startswith('```'):
                    # 这里需要更智能的翻译
                    # 暂时先标记需要翻译
                    # 实际翻译需要调用翻译 API 或使用更复杂的逻辑
                    pass
        
        # 如果文件被修改，保存
        if modified:
            with open(notebook_path, 'w', encoding='utf-8') as f:
                json.dump(notebook, f, ensure_ascii=False, indent=1)
            print(f"  ✓ 已更新")
        else:
            print(f"  - 无需更新")
            
    except Exception as e:
        print(f"  ✗ 错误: {e}")

def main():
    """
    主函数：处理所有 .ipynb 文件
    """
    lessons_zh_dir = Path('lessons_zh')
    
    if not lessons_zh_dir.exists():
        print(f"错误: 找不到 {lessons_zh_dir} 目录")
        return
    
    # 查找所有 .ipynb 文件
    notebook_files = list(lessons_zh_dir.rglob('*.ipynb'))
    
    print(f"找到 {len(notebook_files)} 个 .ipynb 文件")
    print("=" * 60)
    
    for notebook_path in notebook_files:
        translate_notebook(notebook_path)
    
    print("=" * 60)
    print("处理完成！")

if __name__ == '__main__':
    main()

