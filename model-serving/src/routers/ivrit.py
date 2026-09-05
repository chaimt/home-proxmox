from fastapi import APIRouter, File, UploadFile, HTTPException
from typing import Optional
from enum import Enum
import tempfile
import os
import logging
import requests
from fastapi.responses import JSONResponse, PlainTextResponse
import faster_whisper
from config import AppSettings

router = APIRouter(
    prefix="/ivrit",
    tags=["ivrit"]
)


class ResponseFormat(str, Enum):
    json = "json"
    text = "text"

logger = logging.getLogger(__name__)

# Some clients (e.g. n8n forwarding WhatsApp/Telegram voice notes) tag
# audio-only recordings with a video/* mime type instead of audio/*.
# faster-whisper decodes via ffmpeg, which happily extracts audio from
# these containers, so we allow them through the content-type check.
ADDITIONAL_ALLOWED_CONTENT_TYPES = {
    "video/3gpp",
    "video/3gpp2",
    "video/mp4",
    "video/webm",
    "video/quicktime",
    "application/octet-stream",
}


# Global model variable
model = None
model_name = None


def load_model():
    global model
    global model_name
    cpu_threads = AppSettings().cpu_threads
    logger.info("Starting model loading process...")
    try:
        logger.info(f"Loading Whisper model with cpu_threads={cpu_threads}...")
        model = faster_whisper.WhisperModel(
            "ivrit-ai/whisper-large-v3-turbo-ct2",
            device="cpu",  # Change to "cuda" if you have GPU
            compute_type="int8",  # Options: int8, int16, float16, float32
            cpu_threads=cpu_threads
        )
        model_name = "ivrit-ai/whisper-large-v3-turbo-ct2"
        logger.info(f"Model {model_name} loaded successfully!")
    except Exception as e:
        logger.error(f"Failed to load model: {e}", exc_info=True)
        raise e

@router.get("/health")
async def health_check(local_model=None):
    """Check if model is loaded and ready"""
    logger.info("Health check requested")
    if local_model is None:
        global model
        if model is None:
            logger.info("Model not loaded")
            #load_model()
        if model is None:
            logger.error("Model failed to load during health check")
            return JSONResponse(
                status_code=503,
                content={"status": "unhealthy", "message": "Model not loaded"}
            )
    global model_name
    logger.info("Health check successful")
    return {"status": "healthy", "message": "Model is ready", "model_name": model_name} 

@router.post("/transcribe")
async def transcribe_audio(
    file: UploadFile = File(...),
    language: Optional[str] = None,
    task: str = "transcribe",  # "transcribe" or "translate"
    response_format: ResponseFormat = ResponseFormat.json,
    local_model=None
):
    """
    Transcribe audio file to text

    Args:
        file: Audio file (WAV, MP3, M4A, etc.)
        language: Language code (e.g., 'en', 'he', 'ar'). Auto-detect if None
        task: Either 'transcribe' or 'translate'
        response_format: Either 'json' (full details) or 'text' (plain transcribed text)

    Returns:
        JSON response containing:
            - detected_language: Detected language code
            - segments: List of transcribed segments with timing and confidence
            - text: Full transcribed text
        Or, if response_format is 'text', a plain text response with just the transcribed text.
    """
    logger.info(f"Received transcription request - File: {file.filename}, Language: {language}, Task: {task}, Format: {response_format}")
    if local_model is None:
        global model
        if model is None:
            logger.info("Model not loaded, attempting to load...")
            load_model()
        
        if model is None:
            logger.error("Model failed to load during transcription request")
            raise HTTPException(status_code=503, detail="Model not loaded")
    local_model = model
    
    # Check file type
    content_type = file.content_type or ""
    if not content_type.startswith('audio/') and content_type not in ADDITIONAL_ALLOWED_CONTENT_TYPES:
        logger.warning(f"Invalid file type received: {file.content_type}")
        raise HTTPException(
            status_code=400,
            detail="File must be an audio file"
        )
    
    try:
        # Save uploaded file temporarily
        logger.debug("Saving uploaded file to temporary location")
        with tempfile.NamedTemporaryFile(delete=False, suffix=".tmp") as temp_file:
            content = await file.read()
            temp_file.write(content)
            temp_file_path = temp_file.name

        logger.info(f"Processing file: {file.filename} ({len(content)} bytes), saved to {temp_file_path}")

        # Transcribe using faster-whisper
        logger.debug(f"Starting transcription process (language={language}, task={task})")
        segments, info = local_model.transcribe(
            temp_file_path,
            language=language,
            task=task,
            beam_size=5,
            vad_filter=True,  # Voice activity detection
            vad_parameters=dict(min_silence_duration_ms=500)
        )
        logger.debug(f"Detected language: {info.language} (probability={info.language_probability}), duration={info.duration}s")

        # Collect results
        logger.debug("Processing transcription results")
        transcription_segments = []
        full_text = ""

        for segment in segments:
            segment_data = {
                "start": segment.start,
                "end": segment.end,
                "text": segment.text.strip(),
                "confidence": getattr(segment, 'avg_logprob', None)
            }
            transcription_segments.append(segment_data)
            full_text += segment.text.strip() + " "
            logger.debug(f"Segment [{segment.start:.2f}-{segment.end:.2f}]: {segment_data['text']}")

        logger.info(f"Transcribed {len(transcription_segments)} segments, {len(full_text)} characters")

        # Clean up temporary file
        logger.debug(f"Cleaning up temporary file {temp_file_path}")
        os.unlink(temp_file_path)

        logger.info("Transcription completed successfully")
        if response_format == "text":
            return PlainTextResponse(full_text.strip())

        return {
            "filename": file.filename,
            "language": info.language,
            "language_probability": info.language_probability,
            "duration": info.duration,
            "full_text": full_text.strip(),
            "segments": transcription_segments,
            "task": task
        }

    except Exception as e:
        # Clean up temporary file in case of error
        if 'temp_file_path' in locals():
            try:
                logger.debug(f"Attempting to clean up temporary file {temp_file_path} after error")
                os.unlink(temp_file_path)
            except Exception as cleanup_error:
                logger.warning(f"Failed to clean up temporary file {temp_file_path}: {cleanup_error}")

        logger.error(f"Transcription error: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail=f"Transcription failed: {str(e)}")

@router.post("/transcribe/url")
async def transcribe_from_url(
    audio_url: str,
    language: Optional[str] = None,
    task: str = "transcribe",
    response_format: ResponseFormat = ResponseFormat.json,
    model=None
):
    """
    Transcribe audio from URL

    Args:
        audio_url: URL to audio file
        language: Language code (e.g., 'en', 'he', 'ar'). Auto-detect if None
        task: Either 'transcribe' or 'translate'
        response_format: Either 'json' (full details) or 'text' (plain transcribed text)
    """
    logger.info(f"Received URL transcription request - URL: {audio_url}, Language: {language}, Task: {task}, Format: {response_format}")
    if model is None:
        logger.error("Model not available for URL transcription")
        raise HTTPException(status_code=503, detail="Model not loaded")
    
    try:
        # Download audio file
        logger.info(f"Downloading audio file from {audio_url}")
        response = requests.get(audio_url, timeout=30)
        response.raise_for_status()
        logger.debug(f"Downloaded {len(response.content)} bytes from {audio_url}")

        # Save to temporary file
        logger.debug("Saving downloaded file to temporary location")
        with tempfile.NamedTemporaryFile(delete=False, suffix=".tmp") as temp_file:
            temp_file.write(response.content)
            temp_file_path = temp_file.name

        logger.info(f"Processing URL: {audio_url}, saved to {temp_file_path}")

        # Transcribe
        logger.debug(f"Starting transcription process (language={language}, task={task})")
        segments, info = model.transcribe(
            temp_file_path,
            language=language,
            task=task,
            beam_size=5,
            vad_filter=True,
            vad_parameters=dict(min_silence_duration_ms=500)
        )
        logger.debug(f"Detected language: {info.language} (probability={info.language_probability}), duration={info.duration}s")

        # Collect results
        logger.debug("Processing transcription results")
        transcription_segments = []
        full_text = ""

        for segment in segments:
            segment_data = {
                "start": segment.start,
                "end": segment.end,
                "text": segment.text.strip(),
                "confidence": getattr(segment, 'avg_logprob', None)
            }
            transcription_segments.append(segment_data)
            full_text += segment.text.strip() + " "
            logger.debug(f"Segment [{segment.start:.2f}-{segment.end:.2f}]: {segment_data['text']}")

        logger.info(f"Transcribed {len(transcription_segments)} segments, {len(full_text)} characters")

        # Clean up
        logger.debug(f"Cleaning up temporary file {temp_file_path}")
        os.unlink(temp_file_path)

        logger.info("URL transcription completed successfully")
        if response_format == "text":
            return PlainTextResponse(full_text.strip())

        return {
            "url": audio_url,
            "language": info.language,
            "language_probability": info.language_probability,
            "duration": info.duration,
            "full_text": full_text.strip(),
            "segments": transcription_segments,
            "task": task
        }

    except Exception as e:
        if 'temp_file_path' in locals():
            try:
                logger.debug(f"Attempting to clean up temporary file {temp_file_path} after error")
                os.unlink(temp_file_path)
            except Exception as cleanup_error:
                logger.warning(f"Failed to clean up temporary file {temp_file_path}: {cleanup_error}")

        logger.error(f"URL transcription error: {e}", exc_info=True)
        raise HTTPException(status_code=500, detail=f"Transcription failed: {str(e)}")