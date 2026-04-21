# 🛡 SafeStay — AI Privacy Shield v2.3

> Hidden camera detector combining YOLOv8 AI vision, passive network scanning,
> IR frequency analysis, and RSA-signed forensic PDF reports.

---

## 🗂 Project Structure

```
safestay/
├── backend/
│   ├── main.py          ← FastAPI REST API  (port 8000)
│   ├── detector.py      ← YOLOv8 + Hough Circle lens engine
│   ├── scanner.py       ← Scapy ARP + Shannon Entropy scanner
│   └── forensics.py     ← RSA-2048 + ReportLab PDF generator
├── frontend/
│   ├── app.py           ← Streamlit dashboard  (port 8501)
│   └── components/
│       └── visualizer.py ← PyVista / Matplotlib 3D twin renderer
├── models/
│   └── README.md        ← Where to place yolov8n_safe.pt
├── start.sh             ← Linux/macOS unified launcher
├── start.bat            ← Windows unified launcher
├── requirements.txt
└── .env                 ← Environment variables (edit before running)
```

---

## ⚡ Quick Start

### 1. Install dependencies

```bash
pip install -r requirements.txt
```

> **Note:** `pyvista` requires a display or virtual framebuffer on headless servers:
> ```bash
> pip install pyvista[all]
> # On headless Linux: apt install libgl1-mesa-glx xvfb
> ```

### 2. Configure `.env`

Edit `.env` to set ports, confidence thresholds, and RSA key paths.

### 3. Start both services

**Linux / macOS:**
```bash
bash start.sh
```

**Windows:**
```
start.bat
```

This will launch:
- **Backend API** → `http://localhost:8000`
- **Streamlit Dashboard** → `http://localhost:8501`
- **API Docs (Swagger)** → `http://localhost:8000/docs`

---

## 🔌 API Endpoints

| Method | Path | Description |
|--------|------|-------------|
| `GET` | `/health` | Health check |
| `POST` | `/scan/ai` | Run YOLOv8 lens detection |
| `POST` | `/scan/network` | Run Scapy network scan |
| `POST` | `/scan/full` | Full fusion scan |
| `POST` | `/generate-report` | Generate RSA-signed PDF |
| `GET` | `/api/report/download` | Download PDF report |
| `POST` | `/verify-integrity` | Verify scan hash |
| `GET` | `/verify-last` | Verify last report |
| `GET` | `/api/stats` | Session statistics |

---

## 🤖 YOLOv8 Model

The app uses `models/yolov8n_safe.pt` — a fine-tuned nano YOLOv8 model.

- If the model file is missing, detection falls back to demo data automatically.
- To use the standard YOLOv8n model: `pip install ultralytics` and set `YOLO_MODEL_PATH=yolov8n.pt`.

---

## 🔐 Forensic PDF

The Evidence Vault generates a SHA-256 + RSA-2048 signed PDF certificate including:
- 3D coordinates of all detected threats
- AI confidence scores and Hough circle radii
- Network device table with entropy readings
- Cryptographic hash chain for evidence integrity

---

## 🧪 Demo Mode

If the backend is offline, the frontend falls back to **demo data** showing a
realistic CRITICAL threat scenario with two simulated cameras detected.

---

## ⚙️ Advanced Configuration

### Custom ports

```bash
BACKEND_PORT=9000 FRONTEND_PORT=9501 bash start.sh
```

### Environment variables

| Variable | Default | Description |
|----------|---------|-------------|
| `PORT` | `8000` | Backend port |
| `STREAMLIT_PORT` | `8501` | Frontend port |
| `YOLO_CONFIDENCE` | `0.40` | Detection threshold |
| `SAFESTAY_PRIVATE_KEY_PEM` | (auto-gen) | RSA private key PEM |
| `REPORT_OUTPUT_DIR` | `/tmp/safestay_reports` | PDF output directory |

---

## 📄 License

For personal privacy protection in rented accommodations.
Report suspicious findings to local authorities.

🛡 SafeStay AI Core v2.3 · Gradient Forge
