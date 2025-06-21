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
    --log-level debug 
