"""
F.R.I.D.A.Y. 2.0 // Dalal Street AI Wealth Director Root Entrypoint
Ensures 100% universal compatibility across Render, Heroku, Docker, and local development.
"""
import os
import sys

# Ensure root directory and backend directory are in sys.path
BASE_DIR = os.path.dirname(os.path.abspath(__file__))
if BASE_DIR not in sys.path:
    sys.path.insert(0, BASE_DIR)

from backend.main import app

if __name__ == "__main__":
    import uvicorn
    # Render dynamically injects PORT; fallback to 8000 for local dev
    port = int(os.environ.get("PORT", 8000))
    uvicorn.run("main:app", host="0.0.0.0", port=port, reload=False)
