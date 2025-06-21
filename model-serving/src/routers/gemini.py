import logging
from google import genai
from google.genai.types import UploadFileConfig
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
    mime_type: str = None,    
    local_model=None,    
):
    """
    Execute Gemini model inference on an uploaded file with a custom prompt.
    
    This endpoint uploads a file to Gemini and processes it according to the provided prompt.
    The file is temporarily stored on disk, uploaded to Gemini's file service, and then
    processed by the specified model.
    
    Args:
        file (UploadFile): The file to be processed. Required.
        prompt (str, optional): The prompt/instruction for processing the file. 
                               Defaults to Hebrew audio transcription prompt.
        mime_type (str, optional): The MIME type of the file. If not provided, 
                                  will be guessed from the filename.
        local_model (str, optional): The Gemini model to use. 
                                   Defaults to "gemini-2.5-flash".
    
    Returns:
        dict: A dictionary containing the model's response text.
              Format: {"text": "model_response"}
    
    Raises:
        HTTPException: If there's an error processing the file or calling the Gemini API.
    
    Example:
        Using curl to call this endpoint:
        
        ```bash
        curl -X POST "http://localhost:8000/gemini/execute" \
             -H "Content-Type: multipart/form-data" \
             -F "file=@/path/to/your/audio.mp3" \
             -F "prompt=Translate this audio to English and provide a summary" \
             -F "mime_type=audio/mpeg" \
             -F "local_model=gemini-2.5-flash"
        ```
        
        Or with default values:
        
        ```bash
        curl -X POST "http://localhost:8000/gemini/execute" \
             -H "Content-Type: multipart/form-data" \
             -F "file=@/path/to/your/audio.mp3"
        ```
    """
    if not local_model:
        local_model = "gemini-2.5-flash"
    config = None
    if not mime_type:
        logger.info(f"No mime_type provided, attempting to guess from filename: {file.filename}")
        mime_type, _ = mimetypes.guess_type(file.filename)
    client = genai.Client(api_key=AppSettings().gemini_api)
    file_extension = os.path.splitext(file.filename)[1]
    logger.info(f"Processing file: {file.filename} with model: {local_model} and mime_type: {mime_type}")
    logger.info(f"Using prompt: {prompt}")
    
    temp_file_path = None
    try:
        with tempfile.NamedTemporaryFile(delete=False, suffix=file_extension) as temp_file:
            logger.info(f"Writing temporary file to: {temp_file.name}")
            content = await file.read()
            temp_file.write(content)
            temp_file_path = temp_file.name

        myfile = client.files.upload(file=temp_file_path, config=UploadFileConfig(mime_type=mime_type))

        response = client.models.generate_content(
            model=local_model, contents=[prompt, myfile]
        )

        return {
            "text": response.text
        }
    finally:
        # Clean up temporary file
        if temp_file_path and os.path.exists(temp_file_path):
            try:
                os.unlink(temp_file_path)
                logger.info(f"Cleaned up temporary file: {temp_file_path}")
            except Exception as e:
                logger.warning(f"Failed to clean up temporary file {temp_file_path}: {e}")
