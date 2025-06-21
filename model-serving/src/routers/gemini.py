import logging
from google import genai
from fastapi import APIRouter, File, UploadFile, HTTPException
import tempfile
import os
import mimetypes

from config import AppSettings

router = APIRouter(
    prefix="/gemini",
    tags=["gemini"]
)

logger = logging.getLogger(__name__)


@router.post("/execute")
async def execute(
    file: UploadFile = File(...),
    prompt: str = "Translate this audio clip in hebrew. Note there are two people in it, and transcribe the conversation in detail in hebrew.",
    local_model=None,    
):
    if not local_model:
        local_model = "gemini-2.5-flash"
    client = genai.Client(api_key=AppSettings().gemini_api)
    file_extension = os.path.splitext(file.filename)[1]
    
    # Determine MIME type based on file extension
    mime_type, _ = mimetypes.guess_type(file.filename)
    if not mime_type:
        # Fallback MIME types for common audio formats
        mime_type_map = {
            '.mp3': 'audio/mpeg',
            '.wav': 'audio/wav',
            '.m4a': 'audio/mp4',
            '.aac': 'audio/aac',
            '.ogg': 'audio/ogg',
            '.flac': 'audio/flac',
            '.webm': 'audio/webm'
        }
        mime_type = mime_type_map.get(file_extension.lower(), 'application/octet-stream')
    
    with tempfile.NamedTemporaryFile(delete=False, suffix=file_extension) as temp_file:
        content = await file.read()
        temp_file.write(content)
        temp_file_path = temp_file.name

        myfile = client.files.upload(file=temp_file_path, mime_type=mime_type)

        response = client.models.generate_content(
            model=local_model, contents=[prompt, myfile]
        )

    return {
        "text": response.text
    }
