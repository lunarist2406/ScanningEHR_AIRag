# Scanning EHR Record by AI RAG: Intelligent Medical Record Digitalization

**Scanning EHR Record by AI RAG** là hệ thống số hóa hồ sơ y tế thông minh, sử dụng kiến trúc **RAG (Retrieval-Augmented Generation)** để chuyển đổi các tài liệu y khoa không cấu trúc (Scan, PDF, Hình ảnh) thành dữ liệu máy có thể đọc được (Structured Data) với độ chính xác cao.

---

## 🌟 Tính năng nổi bật
* **Hybrid OCR Engine:** Kết hợp **Chandra-OCR** và **Docling** để xử lý hoàn hảo từ văn bản thuần đến các bảng biểu y tế phức tạp.
* **Semantic Extraction:** Sử dụng LLMs để "hiểu" nội dung y khoa, trích xuất thông tin mà không cần định dạng mẫu (Template-less).
* **Enterprise Architecture:** Cấu trúc code mô-đun hóa, dễ dàng mở rộng và bảo trì.
* **Multi-LLM Support:** Tích hợp **LiteLLM** cho phép chuyển đổi linh hoạt giữa Gemini, GPT-4, hoặc Claude tùy theo nhu cầu chi phí/hiệu năng.

---

## 🏗️ Kiến trúc hệ thống & Luồng dữ liệu

Quy trình xử lý của hệ thống được chuẩn hóa qua 4 giai đoạn:

1.  **Ingestion Layer:** FastAPI nhận file và kiểm tra định dạng.
2.  **Processing Layer:** * **Docling/Chandra-OCR** bóc tách văn bản thô và cấu trúc bảng.
    * Văn bản được phân mảnh (Chunking) để tối ưu cho việc truy vấn.
3.  **Indexing Layer:** **LlamaIndex** xây dựng Vector Index, cho phép LLM truy xuất ngữ cảnh chính xác.
4.  **Reasoning Layer:** LLM phân tích ngữ cảnh và trả về JSON chuẩn hóa theo schema định sẵn.

---

## 📂 Cấu trúc dự án (Standardized)

```text
ScanningEHR_AIRag/
├── app/
│   ├── main.py              # Entrypoint khởi tạo FastAPI app
│   ├── config.py            # Quản lý cấu hình (Env vars, API Keys, Settings)
│   ├── routers/             # Định nghĩa các Endpoint API
│   │   ├── records.py       # API Upload, xử lý & lưu trữ hồ sơ
│   │   └── query.py         # API Truy vấn/Chat với dữ liệu hồ sơ
│   ├── services/            # Logic nghiệp vụ chính (Core Logic)
│   │   ├── ocr_engine.py    # Xử lý OCR với Chandra & Docling
│   │   ├── llm_pipeline.py  # Điều phối LlamaIndex & RAG workflow
│   │   └── blockchain_sync.py # [Tùy chọn] Đồng bộ dữ liệu sang EHR Blockchain
│   ├── models/              # Định nghĩa Data Models (Pydantic & DB Schemas)
│   │   ├── request.py       # Validation dữ liệu đầu vào
│   │   └── response.py      # Định dạng dữ liệu đầu ra (JSON format)
│   └── utils/               # Công cụ hỗ trợ
│       ├── logger.py        # Ghi log hệ thống
│       └── helpers.py       # Các hàm bổ trợ xử lý file/string
├── .env                     # Biến môi trường (Keys, Port, DB)
├── requirements.txt         # Danh sách thư viện
└── README.md                # Tài liệu hướng dẫn
```

---

## 🛠️ Cài đặt & Triển khai

### 1. Chuẩn bị môi trường
Sử dụng script tự động để thiết lập môi trường ảo và cài đặt thư viện:

* **Windows:** `install.bat`
* **Linux/MacOS:** ```bash
    chmod +x install.sh && ./install.sh
    ```

### 2. Cấu hình hệ thống
Tạo file `.env` tại thư mục gốc:
```env
# LLM Configuration
GEMINI_API_KEY=your_gemini_key
LITELLM_MODEL=gemini/gemini-1.5-pro

# Server Configuration
PORT=8000
DEBUG=True
```

### 3. Khởi chạy
```bash
uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload
```

---

## 📡 Tài liệu API (Tóm tắt)

### 📤 Upload & Trích xuất dữ liệu
* **Method:** `POST`
* **Path:** `/api/v1/records/upload`
* **Payload:** `multipart/form-data` (file: .pdf, .png, .jpg)

**Kết quả trả về:**
```json
{
  "request_id": "uuid-12345",
  "status": "completed",
  "extracted_data": {
    "patient_info": {
      "name": "Lý Văn Mỹ",
      "age": 22
    },
    "clinical_notes": "Viêm họng cấp, cần theo dõi thêm.",
    "structured_json": { ... }
  }
}
```

---

## 🧩 Công nghệ sử dụng
* **Backend:** FastAPI (Python 3.10+)
* **RAG Framework:** LlamaIndex
* **OCR:** Chandra-OCR & IBM Docling
* **LLM Gateway:** LiteLLM
* **Data Validation:** Pydantic v2

---
*Dự án này là một phần trong hệ sinh thái EHR Blockchain, tập trung vào việc giải quyết bài toán nhập liệu tự động trong y tế.*