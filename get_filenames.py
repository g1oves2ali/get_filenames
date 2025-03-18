# get_filenames.py
import os
import pyperclip

def get_filenames():
    # 获取当前工作目录
    current_dir = os.getcwd()
    
    # 获取所有文件列表（排除目录）
    files = [f for f in os.listdir(current_dir) if os.path.isfile(os.path.join(current_dir, f))]
    
    # 拼接为换行分隔的字符串
    text = '\n'.join(files)
    
    # 复制到剪贴板
    pyperclip.copy(text)
    print(f"已复制 {len(files)} 个文件名到剪贴板")

if __name__ == "__main__":
    get_filenames()