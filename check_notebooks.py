#!/usr/bin/env python3
"""
检查lessons_zh目录下所有notebook文件是否可以在线运行
"""
import json
import os
import sys
from pathlib import Path
from typing import List, Dict, Tuple
import re

class NotebookChecker:
    def __init__(self, root_dir: str):
        self.root_dir = Path(root_dir)
        self.issues = []
        self.checked_files = []
        
    def find_notebooks(self) -> List[Path]:
        """查找所有.ipynb文件"""
        notebooks = list(self.root_dir.rglob("*.ipynb"))
        # 排除checkpoints目录
        notebooks = [n for n in notebooks if ".ipynb_checkpoints" not in str(n)]
        return sorted(notebooks)
    
    def check_json_valid(self, notebook_path: Path) -> Tuple[bool, dict]:
        """检查notebook JSON格式是否有效"""
        try:
            with open(notebook_path, 'r', encoding='utf-8') as f:
                content = json.load(f)
            return True, content
        except json.JSONDecodeError as e:
            return False, {"error": str(e)}
        except Exception as e:
            return False, {"error": str(e)}
    
    def extract_code_cells(self, notebook_content: dict) -> List[str]:
        """提取所有代码单元格的内容"""
        code_cells = []
        for cell in notebook_content.get("cells", []):
            if cell.get("cell_type") == "code":
                source = cell.get("source", [])
                if isinstance(source, list):
                    code = "".join(source)
                else:
                    code = source
                code_cells.append(code)
        return code_cells
    
    def check_imports(self, code: str, notebook_path: Path) -> List[str]:
        """检查import语句，识别可能的依赖问题"""
        issues = []
        # 检查常见的外部库
        import_pattern = r'^\s*import\s+(\w+)|^\s*from\s+(\w+)'
        imports = re.findall(import_pattern, code, re.MULTILINE)
        
        # 检查特殊导入
        if "import cv2" in code and "opencv" not in str(notebook_path).lower():
            # OpenCV需要额外安装
            pass
        
        # 检查torch和tensorflow
        if "import torch" in code or "from torch" in code:
            issues.append("需要PyTorch库")
        if "import tensorflow" in code or "import tf" in code or "from tensorflow" in code:
            issues.append("需要TensorFlow库")
        
        return list(set(issues))
    
    def check_file_paths(self, code: str, notebook_path: Path) -> List[str]:
        """检查代码中的文件路径引用"""
        issues = []
        notebook_dir = notebook_path.parent
        
        # 检查常见的文件操作
        file_patterns = [
            r'["\']([^"\']+\.(jpg|jpeg|png|gif|mp4|json|txt|ttl|ged|py))["\']',
            r'open\(["\']([^"\']+)["\']',
            r'cv2\.imread\(["\']([^"\']+)["\']',
            r'plt\.imread\(["\']([^"\']+)["\']',
            r'np\.load\(["\']([^"\']+)["\']',
            r'pd\.read_csv\(["\']([^"\']+)["\']',
        ]
        
        for pattern in file_patterns:
            matches = re.findall(pattern, code)
            for match in matches:
                if isinstance(match, tuple):
                    file_path = match[0]
                else:
                    file_path = match
                
                # 跳过http/https URLs
                if file_path.startswith(('http://', 'https://')):
                    continue
                
                # 检查相对路径
                if not file_path.startswith('/'):
                    full_path = notebook_dir / file_path
                    if not full_path.exists() and not file_path.startswith('.') and not file_path.startswith('/'):
                        issues.append(f"可能缺少文件: {file_path}")
        
        return issues
    
    def check_external_py_imports(self, code: str, notebook_path: Path) -> List[str]:
        """检查是否导入外部.py文件"""
        issues = []
        notebook_dir = notebook_path.parent
        
        # 检查from .xxx import 或 import xxx (可能是本地文件)
        local_import_pattern = r'from\s+([\.\w]+)\s+import|import\s+([\.\w]+)'
        matches = re.findall(local_import_pattern, code)
        
        for match in matches:
            module = match[0] if match[0] else match[1]
            # 跳过标准库和已知第三方库
            if module.startswith('.'):
                # 相对导入
                module_name = module.lstrip('.')
                py_file = notebook_dir / f"{module_name}.py"
                if not py_file.exists():
                    # 检查父目录
                    parent_py = notebook_dir.parent / f"{module_name}.py"
                    if not parent_py.exists():
                        issues.append(f"可能缺少Python模块: {module_name}.py")
        
        return issues
    
    def check_syntax_errors(self, code: str) -> List[str]:
        """检查基本语法错误（简单检查）"""
        issues = []
        try:
            compile(code, '<string>', 'exec')
        except SyntaxError as e:
            # 某些语法错误可能是故意的（比如不完整的代码示例）
            # 只报告明显的错误
            if "invalid syntax" in str(e).lower():
                issues.append(f"可能的语法错误: {str(e)[:100]}")
        except Exception:
            # 忽略其他编译错误（可能是代码片段）
            pass
        return issues
    
    def check_cell_outputs(self, notebook_content: dict) -> List[str]:
        """检查是否有大量的输出数据（可能不适合在线运行）"""
        issues = []
        total_output_size = 0
        for cell in notebook_content.get("cells", []):
            if cell.get("cell_type") == "code":
                outputs = cell.get("outputs", [])
                for output in outputs:
                    if "data" in output:
                        # 检查输出大小
                        for key, value in output["data"].items():
                            if isinstance(value, list):
                                total_output_size += len(str(value))
        
        if total_output_size > 1000000:  # 1MB
            issues.append(f"输出数据较大 ({total_output_size} 字节)，可能影响在线加载")
        
        return issues
    
    def check_notebook(self, notebook_path: Path) -> Dict:
        """检查单个notebook文件"""
        result = {
            "file": str(notebook_path.relative_to(self.root_dir)),
            "valid_json": False,
            "cells_count": 0,
            "code_cells_count": 0,
            "issues": [],
            "warnings": []
        }
        
        # 检查JSON有效性
        valid, content = self.check_json_valid(notebook_path)
        if not valid:
            result["issues"].append(f"JSON格式无效: {content.get('error', 'Unknown error')}")
            return result
        
        result["valid_json"] = True
        result["cells_count"] = len(content.get("cells", []))
        
        # 提取代码单元格
        code_cells = self.extract_code_cells(content)
        result["code_cells_count"] = len(code_cells)
        
        if len(code_cells) == 0:
            result["warnings"].append("没有代码单元格")
            return result
        
        # 合并所有代码
        all_code = "\n".join(code_cells)
        
        # 检查各种问题
        file_path_issues = []
        import_issues = []
        syntax_issues = []
        external_py_issues = []
        
        for code in code_cells:
            file_path_issues.extend(self.check_file_paths(code, notebook_path))
            import_issues.extend(self.check_imports(code, notebook_path))
            syntax_issues.extend(self.check_syntax_errors(code))
            external_py_issues.extend(self.check_external_py_imports(code, notebook_path))
        
        result["issues"].extend(list(set(file_path_issues)))
        result["issues"].extend(list(set(import_issues)))
        result["issues"].extend(list(set(syntax_issues)))
        result["issues"].extend(list(set(external_py_issues)))
        
        # 检查输出数据大小
        output_issues = self.check_cell_outputs(content)
        result["warnings"].extend(output_issues)
        
        return result
    
    def run_check(self) -> Dict:
        """运行所有检查"""
        notebooks = self.find_notebooks()
        print(f"找到 {len(notebooks)} 个notebook文件")
        
        results = []
        for notebook_path in notebooks:
            print(f"检查: {notebook_path.relative_to(self.root_dir)}")
            result = self.check_notebook(notebook_path)
            results.append(result)
        
        # 统计
        summary = {
            "total": len(results),
            "valid_json": sum(1 for r in results if r["valid_json"]),
            "with_issues": sum(1 for r in results if r["issues"]),
            "with_warnings": sum(1 for r in results if r["warnings"]),
            "results": results
        }
        
        return summary
    
    def print_report(self, summary: Dict):
        """打印检查报告"""
        print("\n" + "="*80)
        print("NOTEBOOK 检查报告")
        print("="*80)
        print(f"\n总计: {summary['total']} 个文件")
        print(f"JSON有效: {summary['valid_json']} 个")
        print(f"存在问题: {summary['with_issues']} 个")
        print(f"有警告: {summary['with_warnings']} 个")
        
        print("\n" + "-"*80)
        print("详细结果:")
        print("-"*80)
        
        for result in summary["results"]:
            status = "✓" if not result["issues"] else "✗"
            print(f"\n{status} {result['file']}")
            print(f"  单元格: {result['cells_count']} (代码: {result['code_cells_count']})")
            
            if result["issues"]:
                print(f"  问题 ({len(result['issues'])}):")
                for issue in result["issues"][:5]:  # 最多显示5个问题
                    print(f"    - {issue}")
                if len(result["issues"]) > 5:
                    print(f"    ... 还有 {len(result['issues'])-5} 个问题")
            
            if result["warnings"]:
                print(f"  警告 ({len(result['warnings'])}):")
                for warning in result["warnings"]:
                    print(f"    - {warning}")
        
        # 列出有问题的文件
        problem_files = [r for r in summary["results"] if r["issues"]]
        if problem_files:
            print("\n" + "-"*80)
            print(f"有问题的文件 ({len(problem_files)} 个):")
            print("-"*80)
            for result in problem_files:
                print(f"  - {result['file']}: {len(result['issues'])} 个问题")

if __name__ == "__main__":
    root_dir = sys.argv[1] if len(sys.argv) > 1 else "lessons_zh"
    checker = NotebookChecker(root_dir)
    summary = checker.run_check()
    checker.print_report(summary)
    
    # 保存JSON报告
    report_file = "notebook_check_report.json"
    with open(report_file, 'w', encoding='utf-8') as f:
        json.dump(summary, f, ensure_ascii=False, indent=2)
    print(f"\n详细报告已保存到: {report_file}")

