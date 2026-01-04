#!/usr/bin/env python3
"""
Jupyter Token 自动获取服务
这个服务会在本地运行，自动获取 Jupyter 服务器的 token 并返回给浏览器
"""

import json
import subprocess
import re
from http.server import HTTPServer, BaseHTTPRequestHandler
from urllib.parse import urlparse, parse_qs
import sys

class TokenHandler(BaseHTTPRequestHandler):
    def do_GET(self):
        """处理 GET 请求，返回 Jupyter token"""
        if self.path == '/token' or self.path == '/token/':
            token = self.get_jupyter_token()
            
            self.send_response(200)
            self.send_header('Content-Type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')  # 允许跨域
            self.end_headers()
            
            response = {
                'success': token is not None,
                'token': token,
                'message': 'Token retrieved successfully' if token else 'No Jupyter server found'
            }
            self.wfile.write(json.dumps(response).encode('utf-8'))
        elif self.path == '/health':
            # 健康检查端点
            self.send_response(200)
            self.send_header('Content-Type', 'application/json')
            self.send_header('Access-Control-Allow-Origin', '*')
            self.end_headers()
            self.wfile.write(json.dumps({'status': 'ok'}).encode('utf-8'))
        else:
            self.send_response(404)
            self.end_headers()
    
    def log_message(self, format, *args):
        """禁用默认的日志输出"""
        pass
    
    def get_jupyter_token(self):
        """从 Jupyter 服务器列表中提取 token"""
        try:
            # 运行 jupyter server list 命令
            result = subprocess.run(
                ['jupyter', 'server', 'list'],
                capture_output=True,
                text=True,
                timeout=5
            )
            
            if result.returncode != 0:
                return None
            
            output = result.stdout
            
            # 查找 token（格式：http://...?token=...）
            token_pattern = r'token=([a-f0-9]+)'
            match = re.search(token_pattern, output)
            
            if match:
                return match.group(1)
            
            return None
        except Exception as e:
            print(f"Error getting token: {e}", file=sys.stderr)
            return None

def run_server(port=8765):
    """启动 token 服务"""
    server_address = ('127.0.0.1', port)
    httpd = HTTPServer(server_address, TokenHandler)
    print(f"✅ Jupyter Token 服务已启动")
    print(f"   地址: http://127.0.0.1:{port}/token")
    print(f"   按 Ctrl+C 停止服务")
    print()
    try:
        httpd.serve_forever()
    except KeyboardInterrupt:
        print("\n服务已停止")
        httpd.server_close()

if __name__ == '__main__':
    import argparse
    parser = argparse.ArgumentParser(description='Jupyter Token 自动获取服务')
    parser.add_argument('--port', type=int, default=8765, help='服务端口（默认: 8765）')
    args = parser.parse_args()
    
    run_server(args.port)

