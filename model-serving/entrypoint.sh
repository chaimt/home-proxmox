#!/bin/bash
set -euo pipefail

echo "Running FastAPI application"

ENV=${ENV:-dev}
WORKERS=$([ "$ENV" = "dev" ] && echo 1 || echo 4)

echo "Environment: $ENV, Running with workers: $WORKERS"

export PYTHONPATH=/app/src/
PORT=${PORT:-8080}

echo "Running on port $PORT"

# Start the FastAPI application with Uvicorn
source /app/.venv/bin/activate
exec uvicorn src.main:app \
    --host 0.0.0.0 \
    --port "$PORT" \
    --workers "$WORKERS" \
    --log-level debug \
    --limit-concurrency 1000 \
    --timeout-keep-alive 30 \
    --limit-max-requests 10000 \
    --limit-max-requests-jitter 1000 \
    --limit-request-line 8192 \
    --limit-request-fields 100 \
    --limit-request-field-size 8192 \
    --http httptools \
    --loop uvloop 
