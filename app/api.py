import json
import base64
from fastapi import APIRouter, File, UploadFile, Form, HTTPException
from typing import Dict, Any
import logging
import json

# Import the OpenAI client from main
from main import openai_client

# Set up logging
logging.basicConfig(level=logging.INFO)
logger = logging.getLogger(__name__)

# Create router
router = APIRouter(prefix="/api", tags=["API"])


PROMPT = """
What is this object in the image?
Please provide a detailed description of the object, including the brand name, model if applicable, year of issue if it can be determined, condition if can be deterined,
if there are any safety considerations for a used item of this type and any other features relevant to someone wanting to buy or sell this item.

Addtionally please provide an estimated value for the object in dollars based on what similar objects have sold for in the past.

Please format your answer as a JSON object with the following fields:
ObjectName
ObjectDescription
ObjectCondition
SafetyConsiderations
ObjectValue
ObjectBrand
ObjectModel
ObjectYear
ObjectFeatures
AdditionalInfo
"""

@router.post("/process", response_model=Dict[str, Any])
async def process_image(
    file: UploadFile = File(...),
    user_data: str = Form(...)
):
    """
    Process an image with ChatGPT.
    
    - **file**: The image file to process
    - **user_data**: JSON string containing user_id and other fields
    
    Example curl command to test this endpoint:
    ```
    curl -X POST \
      http://localhost:8000/api/process \
      -H "Content-Type: multipart/form-data" \
      -F "file=@/path/to/image.jpg" \
      -F 'user_data={"user_id": "123", "additional_field": "value"}'
    ```
    """
    try:
        # Parse user data
        user_json = json.loads(user_data)
        user_id = user_json.get("user_id")
        
        if not user_id:
            raise HTTPException(status_code=400, detail="user_id is required in user_data")
        
        # Log request info
        logger.info(f"Processing request for user_id: {user_id}")
        logger.info(f"File name: {file.filename}, content type: {file.content_type}")
        
        # Read image content
        image_content = await file.read()
        
        # Call ChatGPT API
        response = await call_chatgpt(image_content, user_json)

        print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>')
        print('result', json.dumps(response))
        
        
        return response
    
    except json.JSONDecodeError:
        raise HTTPException(status_code=400, detail="Invalid JSON in user_data")
    except Exception as e:
        logger.error(f"Error processing request: {str(e)}")
        raise HTTPException(status_code=500, detail=f"Error processing request: {str(e)}")

async def call_chatgpt(image_content: bytes, user_data: dict):
    """
    Call the ChatGPT API with the image and user data.
    
    Args:
        image_content: The binary content of the image
        user_data: Dictionary containing user information
    
    Returns:
        Dictionary with the processed response
    """
    try:
        # Convert image to base64
        base64_image = base64.b64encode(image_content).decode("utf-8")
        
        # Extract content type from the first few bytes or default to jpeg
        # This is a simple approach - in production you might want to use a library like python-magic
        image_type = "jpeg"  # Default
        
        # Prepare ChatGPT request
        print('making request to ChatGPT')
        response = await openai_client.chat.completions.create(
            model="gpt-4.1-2025-04-14",
            messages=[
                {
                    "role": "user",
                    "content": [
                        {"type": "text", "text": PROMPT},
                        {"type": "image_url", "image_url": {"url": f"data:image/{image_type};base64,{base64_image}"}}
                    ]
                }
            ]
        )
        
        # Process and return response
        result = {
            "result": response.choices[0].message.content,
            "user_id": user_data.get("user_id"),
            "processed": True
        }
        
        # Add any additional processing here

        
        return result
    
    except Exception as e:
        logger.error(f"Error calling ChatGPT API: {str(e)}")
        raise Exception(f"Error calling ChatGPT API: {str(e)}")
