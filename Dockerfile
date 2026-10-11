# Lightweight Python container for F.R.I.D.A.Y. Equity Research Engine
FROM python:3.11-slim

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy complete application source
COPY . /app/

EXPOSE 8000 10000

CMD ["sh", "-c", "uvicorn main:app --host 0.0.0.0 --port ${PORT:-8000}"]
