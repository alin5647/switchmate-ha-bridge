FROM python:3.9-slim

# Install system dependencies for Bluetooth
RUN apt-get update && apt-get install -y \
    libglib2.0-dev \
    pkg-config \
    bluetooth \
    bluez \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Download the library directly into the image
ADD https://raw.githubusercontent.com/brianpeiris/switchmate/master/switchmate.py .

RUN pip install --no-cache-dir bluepy docopt

ENTRYPOINT ["python", "switchmate.py"]