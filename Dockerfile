FROM python:3.11-slim

# System dependencies
RUN apt-get update -y && apt-get install -y --no-install-recommends \
    gcc \
    libffi-dev \
    ffmpeg \
    aria2 \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# App directory
WORKDIR /app

# Copy project files
COPY . /app

# Python dependencies (MOST IMPORTANT PART)
RUN pip install --no-cache-dir --upgrade pip setuptools wheel
RUN pip install --no-cache-dir gunicorn
RUN pip install --no-cache-dir -r requirements.txt || true

# Environment variable
ENV COOKIES_FILE_PATH="/modules/youtube_cookies.txt"

# Start server (Koyeb port)
CMD gunicorn app:app --bind 0.0.0.0:8000
