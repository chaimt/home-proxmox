from fastapi import APIRouter, File, UploadFile, HTTPException
from typing import Optional
import tempfile
import os
import logging
import requests
from fastapi.responses import JSONResponse
import faster_whisper

router = APIRouter(
    prefix="/ivrit",
    tags=["ivrit"]
)

logger = logging.getLogger(__name__)


# Global model variable
model = None
model_name = None


def load_model():
    global model
    global model_name
    try:    
        logger.info("Loading Whisper model...")
        model = faster_whisper.WhisperModel(
            "ivrit-ai/whisper-large-v3-turbo-ct2",
            device="cpu",  # Change to "cuda" if you have GPU
            compute_type="int8"  # Options: int8, int16, float16, float32
        )
        model_name = "ivrit-ai/whisper-large-v3-turbo-ct2"
        logger.info("Model loaded successfully!")
    except Exception as e:
        logger.error(f"Failed to load model: {e}")
        raise e

@router.get("/health")
async def health_check(local_model=None):
    """Check if model is loaded and ready"""
    if local_model is None:
        global model
        if model is None:
            load_model()
        if model is None:
            return JSONResponse(
                status_code=503,
                content={"status": "unhealthy", "message": "Model not loaded"}
            )
    global model_name
    return {"status": "healthy", "message": "Model is ready", "model_name": model_name} 

@router.post("/transcribe")
async def transcribe_audio(
    file: UploadFile = File(...),
    language: Optional[str] = None,
    task: str = "transcribe",  # "transcribe" or "translate"
    local_model=None
):
    """
    Transcribe audio file to text
    
    Args:
        file: Audio file (WAV, MP3, M4A, etc.)
        language: Language code (e.g., 'en', 'he', 'ar'). Auto-detect if None
        task: Either 'transcribe' or 'translate'
    """
    if local_model is None:
        global model
        if model is None:
            load_model()
        
        if model is None:
            raise HTTPException(status_code=503, detail="Model not loaded")
    local_model = model
    
    # Check file type
    if not file.content_type.startswith('audio/'):
        raise HTTPException(
            status_code=400, 
            detail="File must be an audio file"
        )
    
    try:
        # Save uploaded file temporarily
        with tempfile.NamedTemporaryFile(delete=False, suffix=".tmp") as temp_file:
            content = await file.read()
            temp_file.write(content)
            temp_file_path = temp_file.name
        
        logger.info(f"Processing file: {file.filename}")
        
        # Transcribe using faster-whisper
        segments, info = local_model.transcribe(
            temp_file_path,
            language=language,
            task=task,
            beam_size=5,
            vad_filter=True,  # Voice activity detection
            vad_parameters=dict(min_silence_duration_ms=500)
        )
        
        # Collect results
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
        
        # Clean up temporary file
        os.unlink(temp_file_path)
        
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
                os.unlink(temp_file_path)
            except:
                pass
        
        logger.error(f"Transcription error: {e}")
        raise HTTPException(status_code=500, detail=f"Transcription failed: {str(e)}")

@router.post("/transcribe/url")
async def transcribe_from_url(
    audio_url: str,
    language: Optional[str] = None,
    task: str = "transcribe",
    model=None
):
    """
    Transcribe audio from URL
    
    Args:
        audio_url: URL to audio file
        language: Language code (e.g., 'en', 'he', 'ar'). Auto-detect if None
        task: Either 'transcribe' or 'translate'
    """
    if model is None:
        raise HTTPException(status_code=503, detail="Model not loaded")
    
    try:
        # Download audio file
        response = requests.get(audio_url, timeout=30)
        response.raise_for_status()
        
        # Save to temporary file
        with tempfile.NamedTemporaryFile(delete=False, suffix=".tmp") as temp_file:
            temp_file.write(response.content)
            temp_file_path = temp_file.name
        
        logger.info(f"Processing URL: {audio_url}")
        
        # Transcribe
        segments, info = model.transcribe(
            temp_file_path,
            language=language,
            task=task,
            beam_size=5,
            vad_filter=True,
            vad_parameters=dict(min_silence_duration_ms=500)
        )
        
        # Collect results
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
        
        # Clean up
        os.unlink(temp_file_path)
        
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
                os.unlink(temp_file_path)
            except:
                pass
        
        logger.error(f"URL transcription error: {e}")
        raise HTTPException(status_code=500, detail=f"Transcription failed: {str(e)}") 