@echo off
title SafeStay AI Privacy Shield v2.3

echo.
echo   Shield  SafeStay AI Privacy Shield v2.3
echo   ----------------------------------------
echo.

cd /d "%~dp0"

if exist .env (
  for /f "tokens=1,* delims==" %%a in (.env) do (
    if not "%%a"=="" if not "%%a:~0,1%"=="#" set "%%a=%%b"
  )
  echo   + Loaded .env
)

if "%PORT%"=="" set PORT=8000

python --version >nul 2>&1
if errorlevel 1 (
  echo   X Python not found. Install Python 3.9+
  pause & exit /b 1
)

python -c "import fastapi" >nul 2>&1
if errorlevel 1 (
  echo   - Installing dependencies...
  pip install -r requirements.txt --quiet
)

echo.
echo   - Starting FastAPI backend on port %PORT%...
echo   - Open index.html in your browser for the dashboard
echo.

cd backend
python -m uvicorn main:app --host 0.0.0.0 --port %PORT% --reload
pause
