# Lightweight Python container for F.R.I.D.A.Y. Equity Research Engine
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY backend/ /app/backend/
COPY services/ /app/services/
COPY schemas/ /app/schemas/
COPY prompts/ /app/prompts/
COPY n8n/ /app/n8n/
COPY index.html /app/index.html

ENV PORT=8000
EXPOSE 8000 10000

CMD ["sh", "-c", "uvicorn backend.main:app --host 0.0.0.0 --port ${PORT:-8000}"]
