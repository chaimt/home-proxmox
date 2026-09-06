from pydantic_settings import BaseSettings
from pydantic import field_validator
from single_instance_metaclass import singleton

@singleton
class AppSettings(BaseSettings):
    gemini_api: str = ""
    log_level: str = "INFO"
    cpu_threads: int = 4
    # Needed to download gated pyannote models (e.g. speaker-diarization-community-1)
    # from Hugging Face. Create one at hf.co/settings/tokens and accept the model's
    # user conditions on its Hugging Face page.
    hf_token: str = ""

    @field_validator("log_level")
    @classmethod
    def normalize_log_level(cls, value: str) -> str:
        # logging.basicConfig requires the uppercase level name (e.g. "INFO"),
        # but env vars/.env commonly use lowercase (e.g. "info"). Normalize here
        # so callers don't need to worry about casing.
        return value.upper()

    class Config:
        env_file = ".env"  # Optional: load from .env file if present
        env_file_encoding = "utf-8"
        extra = "allow"
        case_sensitive = False  #
