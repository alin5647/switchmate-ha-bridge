FROM python:3.9-slim

# Install system dependencies + build tools
RUN apt-get update && apt-get install -y \
    build-essential \
    libglib2.0-dev \
    pkg-config \
    bluetooth \
    bluez \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Pull the core library
ADD https://raw.githubusercontent.com/brianpeiris/switchmate/master/switchmate.py .

# Install dependencies (added tabulate here)
RUN pip install --no-cache-dir bluepy docopt tabulate

ENTRYPOINT ["python", "switchmate.py"]