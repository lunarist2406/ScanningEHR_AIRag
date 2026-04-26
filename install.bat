@echo off
REM Xóa venv cũ nếu có
if exist .venv (
    rmdir /s /q .venv
)

REM Tạo venv mới bằng Python 3.14
py -3.14 -m venv .venv
call .venv\Scripts\activate

REM Cài các thư viện từ requirements.txt
py -3.14 -m pip install -r requirements.txt

REM Kiểm tra xung đột dependency
py -3.14 -m pip check
