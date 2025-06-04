from pydantic_settings import BaseSettings
from single_instance_metaclass import singleton

@singleton
class AppSettings(BaseSettings):
    gemini_api: str = ""

    class Config:
        env_file = ".env"  # Optional: load from .env file if present
        env_file_encoding = "utf-8"
        extra = "allow"
        case_sensitive = False  #
