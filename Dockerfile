FROM python:3.12-slim

WORKDIR /code

# Copy requirements và script cài đặt
COPY requirements.txt .
COPY install.sh .

# Cài git để clone openrag
RUN apt-get update && apt-get install -y git

# Chạy script cài đặt (pip install -r + clone openrag + pip install -e src/openrag)
RUN chmod +x install.sh && ./install.sh

# Copy toàn bộ source code app
COPY . .

CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]
