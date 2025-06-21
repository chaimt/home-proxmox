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
    if not local_model:
        local_model = "gemini-2.5-flash"
    client = genai.Client(api_key=AppSettings().gemini_api)
    file_extension = os.path.splitext(file.filename)[1]
    logger.info(f"Processing file: {file.filename} with model: {local_model} and mime_type: {mime_type}")
    logger.info(f"Using prompt: {prompt}")
    
    config = None
    if mime_type:
        config=UploadFileConfig(mime_type=mime_type)        

    with tempfile.NamedTemporaryFile(delete=False, suffix=file_extension) as temp_file:
        logger.info(f"Writing temporary file to: {temp_file.name}")
        content = await file.read()
        temp_file.write(content)
        temp_file_path = temp_file.name

        myfile = client.files.upload(file=temp_file_path, config=config)

        response = client.models.generate_content(
            model=local_model, contents=[prompt, myfile]
        )

    return {
        "text": response.text
    }
