Chào bạn, một dự án kết hợp giữa **Blockchain** (theo hướng EHR mà bạn đang theo đuổi) và **AI (RAG)** là một bước đi cực kỳ ấn tượng cho đồ án tốt nghiệp hoặc Portfolio cá nhân.

Dưới đây là bản chuyên nghiệp hóa của `README.md`, được cấu trúc lại để làm nổi bật tính ứng dụng công nghệ và quy trình kỹ thuật của bạn:

---

# 🚀 ScanningEHR-AIRag: Hệ Thống Số Hóa Hồ Sơ Y Tế Thông Minh

**ScanningEHR-AIRag** là một giải pháp tiên tiến hỗ trợ chuyển đổi các hồ sơ y tế dạng bản quét (Scan/PDF) thành dữ liệu có cấu trúc bằng cách kết hợp sức mạnh của **OCR (Optical Character Recognition)** và **LLMs (Large Language Models)** thông qua kiến trúc **RAG (Retrieval-Augmented Generation)**.



## 🌟 Tính năng cốt lõi
* **Đa dạng hóa đầu vào:** Hỗ trợ xử lý tệp PDF và hình ảnh y tế không cấu trúc.
* **Trích xuất thông minh:** Sử dụng LLM để nhận diện các trường dữ liệu động (Tên bệnh nhân, Chẩn đoán, Phác đồ điều trị,...) mà không cần định nghĩa template cứng nhắc.
* **Xử lý tài liệu phức tạp:** Tích hợp **Docling** để phân tích các cấu trúc bảng biểu và sơ đồ trong tài liệu y khoa.
* **Backend linh hoạt:** Hỗ trợ nhiều LLM hàng đầu (GPT-4, Claude, Gemini) thông qua lớp trung gian **LiteLLM**.

## 🏗️ Kiến trúc hệ thống

Dự án được xây dựng trên luồng xử lý dữ liệu khép kín (Pipeline):

1.  **Ingestion:** FastAPI tiếp nhận hồ sơ y tế từ người dùng.
2.  **Processing:** * **Chandra-OCR** & **Docling** thực hiện bóc tách văn bản thô từ file scan.
    * **LlamaIndex** đóng vai trò Framework điều phối, xây dựng Index từ dữ liệu OCR.
3.  **Extraction:** LLM thực hiện truy vấn trên Index để trích xuất dữ liệu thành định dạng JSON chuẩn hóa.

### Cấu trúc thư mục
```text
project-root/
│── app/
│   │── main.py              # FastAPI entrypoint
│   │── config.py            # cấu hình chung (env, DB, API keys)
│   │── routers/
│   │   │── records.py       # API upload & quản lý hồ sơ
│   │   │── query.py         # API query dữ liệu đã OCR
│   │── services/
│   │   │── ocr_chandra.py   # OCR bằng Chandra
│   │   │── docling_parser.py# parse tài liệu phức tạp
│   │   │── ehr_sync.py      # đồng bộ dữ liệu EHR
│   │   │── llm_pipeline.py  # pipeline LlamaIndex (thay openrag)
│   │── models/
│   │   │── record.py        # schema hồ sơ
│   │   │── query.py         # schema query
│   │── utils/
│   │   │── logger.py        # logging
│   │   │── helpers.py       # tiện ích chung
│   │── context/
│   │   │── edge_tabs.py     # metadata Edge tabs (nếu cần)

```

## 🛠️ Cài đặt & Sử dụng

### 1. Khởi tạo môi trường
Bạn có thể cài đặt nhanh chóng thông qua các script có sẵn:

* **Windows:** Chạy file `install.bat`
* **Linux/MacOS:** ```bash
    chmod +x install.sh
    ./install.sh
    ```

### 2. Cấu hình biến môi trường
Tạo file `.env` tại thư mục gốc và cấu hình API Key cho LLM bạn sử dụng:
```env
GEMINI_API_KEY=your_api_key_here
# Hoặc OPENAI_API_KEY nếu dùng GPT-4
```

### 3. Khởi chạy ứng dụng
Sử dụng **Uvicorn** để chạy Server:
```bash
uvicorn src.main:app --reload
```

## 📡 API Reference

### Upload & Extract Data
**Endpoint:** `POST /upload`

**Request:**
```bash
curl -X POST "http://localhost:8000/upload" -F "file=@path/to/your/medical_record.pdf"
```

**Response (JSON):**
```json
{
  "status": "success",
  "data": {
    "patient_name": "Nguyen Van A",
    "exam_date": "2026-04-20",
    "diagnosis": "Viêm phổi cấp tính",
    "medications": ["Paracetamol", "Amoxicillin"],
    "hospital": "Bệnh viện Đa khoa Trung ương"
  }
}
```

## 🧩 Thành phần công nghệ (Stack)
* **Framework:** FastAPI, LlamaIndex.
* **OCR & Parsing:** Chandra-OCR, Docling.
* **LLM Gateway:** LiteLLM (Hỗ trợ GPT-4, Claude, Gemini, v.v.).
* **Vector DB (Optional):** OpenSearch.

---
*Dự án đang trong quá trình phát triển để tối ưu hóa độ chính xác trong việc nhận diện các thuật ngữ y khoa chuyên sâu.*