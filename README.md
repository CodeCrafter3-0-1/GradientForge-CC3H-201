# 🛡 SafeStay AI Privacy Shield v2.3 — Combined Package

This package contains **both** frontend implementations sharing **one backend**.

## 📁 What's Inside

```
safestay-combined/
├── index.html              ← ✅ NEW: Three.js frontend (open directly in browser)
├── dashboard.html          ← Same as index.html (convenience copy)
├── streamlit-frontend/     ← Original Streamlit + PyVista frontend
├── backend/                ← Shared FastAPI backend (port 8000)
├── models/                 ← Place yolov8n_safe.pt here
├── start.sh                ← Starts backend for HTML frontend
├── start-streamlit.sh      ← Starts backend + Streamlit (port 8501)
├── start.bat               ← Windows launcher
├── requirements.txt
└── .env
```

HTML Frontend 
1. `bash start.sh`
2. Open `index.html` in browser


🛡 SafeStay AI Core v2.3 · Gradient Forge
