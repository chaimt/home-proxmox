import os
from fastapi import FastAPI
import faster_whisper
import logging
from contextlib import asynccontextmanager
from config import AppSettings
from routers import ivrit
from routers import gemini
from fastapi.middleware.cors import CORSMiddleware
from starlette.middleware.base import BaseHTTPMiddleware
from starlette.requests import Request
from starlette.responses import Response
# Set up logging
logging.basicConfig(level=AppSettings().log_level)
logger = logging.getLogger(__name__)


class LargeFileMiddleware(BaseHTTPMiddleware):
    """Middleware to handle large file uploads"""
    
    async def dispatch(self, request: Request, call_next):
        # Set larger limits for multipart form data
        if request.method == "POST" and "multipart/form-data" in request.headers.get("content-type", ""):
            # Increase the maximum size for multipart requests
            request.scope["max_content_size"] = 200 * 1024 * 1024  # 200MB
        
        response = await call_next(request)
        return response


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

# Add middleware for large file uploads
app.add_middleware(LargeFileMiddleware)

# Configure CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Set file size limits for FastAPI
app.state.max_file_size = 200 * 1024 * 1024  # 200MB
app.state.max_part_size = 100 * 1024 * 1024  # 100MB


@app.get("/")
async def root():
    """Health check endpoint"""
    return {"message": "Model Server is running"}


@app.get(
    "/env",
    summary="Get environment variables",
    description="Returns all environment variables available to the application",
    response_description="A dictionary containing all environment variables",
    tags=["Health"],
)
def get_env():
    return {"env": dict(os.environ), "settings": AppSettings().model_dump()}

# Include routers
app.include_router(ivrit.router)
app.include_router(gemini.router)

if __name__ == "__main__":
    import uvicorn
    uvicorn.run(
        app, 
        host="0.0.0.0", 
        port=8080,
        log_level="debug"
    )