# Mina Backend Services

A FastAPI-based API backend that relays requests to ChatGPT.

## Features

- FastAPI backend with async support
- Docker containerization
- Image processing and ChatGPT integration
- Environment variable configuration

## Prerequisites

- Docker and Docker Compose
- OpenAI API key

## Getting Started

1. Clone the repository
2. Copy `.env.example` to `.env` and add your OpenAI API key
3. Build and start the Docker container:

```bash
make build
make start
```

## API Endpoints

### Process Image

Processes an image with ChatGPT and returns the result.

- **URL**: `/api/process`
- **Method**: `POST`
- **Content-Type**: `multipart/form-data`
- **Parameters**:
  - `file`: The image file to process
  - `user_data`: JSON string containing user_id and other fields

#### Example Request

```bash
curl -X POST \
  http://localhost:8000/api/process \
  -H "Content-Type: multipart/form-data" \
  -F "file=@/path/to/image.jpg" \
  -F 'user_data={"user_id": "123", "additional_field": "value"}'
```

#### Example Response

```json
{
  "result": "Analysis from ChatGPT",
  "user_id": "123",
  "processed": true
}
```

## Makefile Commands

- `make build`: Build the Docker image
- `make start`: Start the Docker container
- `make stop`: Stop the Docker container
- `make restart`: Restart the Docker container
- `make logs`: View container logs
- `make clean`: Remove containers and images
- `make dev`: Run the application in development mode
- `make help`: Display help message

## Development

To run the application in development mode:

```bash
make dev
```

## Docker Configuration

The application is containerized using Docker. The Docker configuration includes:

- Python 3.9 base image
- FastAPI application
- Environment variable configuration
- Volume mounting for development

## Environment Variables

Create a `.env` file with the following variables:

```
OPENAI_API_KEY=your_openai_api_key_here
API_DEBUG=false
LOG_LEVEL=INFO
PORT=8000
HOST=0.0.0.0
```
