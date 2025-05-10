from pydantic import BaseModel, Field
from typing import Dict, Any, Optional, List


class UserData(BaseModel):
    """
    Model for user data in the request.
    """
    user_id: str = Field(..., description="Unique identifier for the user")
    additional_fields: Optional[Dict[str, Any]] = Field(default=None, description="Additional fields provided in the request")


class ProcessResponse(BaseModel):
    """
    Model for the response from the process endpoint.
    """
    result: str = Field(..., description="Result from the ChatGPT API")
    user_id: str = Field(..., description="User ID from the request")
    processed: bool = Field(..., description="Whether the request was processed successfully")
    additional_data: Optional[Dict[str, Any]] = Field(default=None, description="Additional data in the response")
