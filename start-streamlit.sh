#!/usr/bin/env bash
# ─────────────────────────────────────────────────────────────────────────────
# SafeStay v2.3 — Unified Startup Script
# Starts FastAPI backend (port 8000) + Streamlit frontend (port 8501)
# Usage:  bash start.sh
#         BACKEND_PORT=9000 FRONTEND_PORT=9501 bash start.sh
# ─────────────────────────────────────────────────────────────────────────────
set -e

BACKEND_PORT="${BACKEND_PORT:-8000}"
FRONTEND_PORT="${FRONTEND_PORT:-8501}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo ""
echo "  ┌──────────────────────────────────────────────┐"
echo "  │   🛡  SafeStay AI Privacy Shield  v2.3       │"
echo "  │   Starting backend + frontend…               │"
echo "  └──────────────────────────────────────────────┘"
echo ""

# Load .env if present
if [ -f "$SCRIPT_DIR/.env" ]; then
    set -o allexport
    source "$SCRIPT_DIR/.env"
    set +o allexport
    echo "  ✓ Loaded .env"
fi

# Export API port so Streamlit can pick it up
export SAFESTAY_API_PORT="$BACKEND_PORT"
export PORT="$BACKEND_PORT"

# ── Start Backend ─────────────────────────────────────────────────────────────
echo "  ▶ Starting FastAPI backend on port $BACKEND_PORT …"
cd "$SCRIPT_DIR/backend"
uvicorn main:app --host 0.0.0.0 --port "$BACKEND_PORT" --reload &
BACKEND_PID=$!
echo "    PID $BACKEND_PID"

# Wait for backend to be ready (up to 15 seconds)
echo "  ⏳ Waiting for backend to be ready…"
for i in $(seq 1 30); do
    if curl -sf "http://localhost:$BACKEND_PORT/health" > /dev/null 2>&1; then
        echo "  ✓ Backend ready at http://localhost:$BACKEND_PORT"
        break
    fi
    sleep 0.5
done

# ── Start Frontend ────────────────────────────────────────────────────────────
echo "  ▶ Starting Streamlit frontend on port $FRONTEND_PORT …"
cd "$SCRIPT_DIR/frontend"
streamlit run app.py \
    --server.port "$FRONTEND_PORT" \
    --server.address 0.0.0.0 \
    --server.headless true \
    --theme.base dark \
    --theme.backgroundColor "#0A0E1A" \
    --theme.primaryColor "#2ECC71" \
    --theme.secondaryBackgroundColor "#0F1528" \
    --theme.textColor "#E8EAF6" &
FRONTEND_PID=$!
echo "    PID $FRONTEND_PID"

echo ""
echo "  ✅ SafeStay is running!"
echo "     Dashboard  →  http://localhost:$FRONTEND_PORT"
echo "     API Docs   →  http://localhost:$BACKEND_PORT/docs"
echo ""
echo "  Press Ctrl+C to stop both services."
echo ""

# ── Cleanup on exit ────────────────────────────────────────────────────────────
cleanup() {
    echo ""
    echo "  Stopping SafeStay…"
    kill $BACKEND_PID  2>/dev/null || true
    kill $FRONTEND_PID 2>/dev/null || true
    echo "  Stopped. Goodbye."
    exit 0
}
trap cleanup SIGINT SIGTERM

# Keep script alive
wait
