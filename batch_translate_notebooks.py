#!/usr/bin/env python3
"""
批量翻译 lessons_zh 文件夹中所有 .ipynb 文件的 markdown cells 为中文
使用 AI 翻译确保准确性
"""

import json
import os
import glob
from pathlib import Path
import re

def is_english_text(text):
    """检查文本是否主要是英文"""
    # 如果包含中文字符，说明已经翻译过
    if any('\u4e00' <= char <= '\u9fff' for char in text):
        return False
    
    # 检查是否包含常见英文单词
    english_words = ['the', 'this', 'that', 'is', 'are', 'we', 'you', 'will', 'can', 'should', 
                     'import', 'function', 'class', 'notebook', 'example', 'let', 'first', 'next']
    text_lower = text.lower()
    english_count = sum(1 for word in english_words if word in text_lower)
    
    # 如果包含多个英文单词，认为是英文
    return english_count >= 2

def needs_translation(cell):
    """判断 cell 是否需要翻译"""
    if cell.get('cell_type') != 'markdown':
        return False
    
    source = cell.get('source', [])
    if isinstance(source, list):
        text = ''.join(source)
    else:
        text = source
    
    # 跳过代码块
    if text.strip().startswith('```'):
        return False
    
    # 检查是否主要是英文
    return is_english_text(text)

def get_markdown_cells(notebook_path):
    """获取 notebook 中所有需要翻译的 markdown cells"""
    try:
        with open(notebook_path, 'r', encoding='utf-8') as f:
            notebook = json.load(f)
        
        cells_to_translate = []
        for idx, cell in enumerate(notebook.get('cells', [])):
            if needs_translation(cell):
                source = cell.get('source', [])
                if isinstance(source, list):
                    text = ''.join(source)
                else:
                    text = source
                cells_to_translate.append({
                    'index': idx,
                    'text': text,
                    'cell': cell
                })
        
        return cells_to_translate, notebook
    except Exception as e:
        print(f"  错误读取文件: {e}")
        return [], None

def main():
    """主函数：列出所有需要翻译的文件和 cells"""
    lessons_zh_dir = Path('lessons_zh')
    
    if not lessons_zh_dir.exists():
        print(f"错误: 找不到 {lessons_zh_dir} 目录")
        return
    
    # 查找所有 .ipynb 文件
    notebook_files = sorted(list(lessons_zh_dir.rglob('*.ipynb')))
    
    print(f"找到 {len(notebook_files)} 个 .ipynb 文件")
    print("=" * 80)
    
    total_cells = 0
    files_with_translations = []
    
    for notebook_path in notebook_files:
        cells_to_translate, notebook = get_markdown_cells(notebook_path)
        if cells_to_translate:
            print(f"\n{notebook_path}:")
            print(f"  需要翻译 {len(cells_to_translate)} 个 markdown cells")
            total_cells += len(cells_to_translate)
            files_with_translations.append({
                'path': str(notebook_path),
                'cells': cells_to_translate
            })
            
            # 显示前3个需要翻译的 cell 预览
            for i, cell_info in enumerate(cells_to_translate[:3]):
                preview = cell_info['text'][:100].replace('\n', ' ')
                print(f"    Cell {cell_info['index']}: {preview}...")
    
    print("\n" + "=" * 80)
    print(f"总计: {len(files_with_translations)} 个文件需要翻译")
    print(f"总计: {total_cells} 个 markdown cells 需要翻译")
    print("\n提示: 使用 edit_notebook 工具逐个处理这些文件")

if __name__ == '__main__':
    main()

