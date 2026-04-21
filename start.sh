#!/usr/bin/env bash
# SafeStay v2.3 — Backend Launcher
# Opens the FastAPI backend; open index.html in your browser separately.

set -e
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

PORT="${PORT:-8000}"

echo ""
echo "  🛡  SafeStay AI Privacy Shield v2.3"
echo "  ────────────────────────────────────"
echo ""

# Load .env if present
if [ -f .env ]; then
  export $(grep -v '^#' .env | xargs)
  echo "  ✓ Loaded .env"
fi

# Check Python
if ! command -v python3 &>/dev/null; then
  echo "  ✗ Python 3 not found. Please install Python 3.9+"
  exit 1
fi

echo "  ✓ Python: $(python3 --version)"

# Install deps if needed
if ! python3 -c "import fastapi" 2>/dev/null; then
  echo "  → Installing dependencies…"
  pip install -r requirements.txt --quiet
fi

echo ""
echo "  → Starting FastAPI backend on port $PORT…"
echo "  → Open index.html in your browser for the dashboard"
echo ""

cd backend
python3 -m uvicorn main:app --host 0.0.0.0 --port "$PORT" --reload
