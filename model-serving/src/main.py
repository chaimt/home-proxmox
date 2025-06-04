import os
from fastapi import FastAPI
import faster_whisper
import logging
from contextlib import asynccontextmanager
from routers import ivrit
from routers import gemini
# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)


@asynccontextmanager
async def lifespan(app: FastAPI):
    """Lifecycle manager for the FastAPI application"""    
    
    yield
    
    # Cleanup code (if needed)
    logger.info("Shutting down...")

app = FastAPI(
    title="Whisper Speech-to-Text API",
    description="FastAPI server for speech-to-text using ivrit-ai/whisper-large-v3-turbo-ct2",
    version="1.0.0",
    docs_url="/swagger",
    lifespan=lifespan
)

@app.get("/")
async def root():
    """Health check endpoint"""
    return {"message": "Whisper Speech-to-Text API is running"}


@app.get(
    "/env",
    summary="Get environment variables",
    description="Returns all environment variables available to the application",
    response_description="A dictionary containing all environment variables",
    tags=["Health"],
)
def get_env():
    return {"env": dict(os.environ)}

# Include routers
app.include_router(ivrit.router)
app.include_router(gemini.router)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(app, host="0.0.0.0", port=8000)