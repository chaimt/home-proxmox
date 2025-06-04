import logging
from google import genai
from fastapi import APIRouter, File, UploadFile, HTTPException
import tempfile
import os

from config import AppSettings

router = APIRouter(
    prefix="/gemini",
    tags=["gemini"]
)

logger = logging.getLogger(__name__)


@router.post("/execute")
async def health_check(
    prompt: str = "Translate this audio clip in hebrew. Note there are two people in it, and transcribe the conversation in detail in hebrew.",
    local_model=None,
    file: UploadFile = File(...),
):
    if not local_model:
        local_model = "gemini-2.0-flash"
    client = genai.Client(api_key=AppSettings().gemini_api)
    file_extension = os.path.splitext(file.filename)[1]
    with tempfile.NamedTemporaryFile(delete=False, suffix=file_extension) as temp_file:
        content = await file.read()
        temp_file.write(content)
        temp_file_path = temp_file.name

        myfile = client.files.upload(file=temp_file_path)

        response = client.models.generate_content(
            model=local_model, contents=[prompt, myfile]
        )

    return {
        "text": response.text
    }
