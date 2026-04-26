#!/bin/bash
set -e

# Xóa venv cũ nếu có
if [ -d ".venv" ]; then
  rm -rf .venv
fi

# Tạo venv mới bằng Python 3.14
python3.14 -m venv .venv
source .venv/bin/activate

# Cài các thư viện từ requirements.txt
pip install -r requirements.txt

# Kiểm tra xung đột dependency
pip check
