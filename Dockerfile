FROM python:3.9-slim

# Install system dependencies + libcap2-bin for permissions
RUN apt-get update && apt-get install -y \
    build-essential \
    libglib2.0-dev \
    pkg-config \
    bluetooth \
    bluez \
    libcap2-bin \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

ADD https://raw.githubusercontent.com/brianpeiris/switchmate/master/switchmate.py .

RUN pip install --no-cache-dir bluepy docopt tabulate

# This command finds the bluepy-helper and gives it persistent scan permissions
RUN find /usr/local/lib -name bluepy-helper -exec setcap 'cap_net_raw,cap_net_admin+eip' {} \;

ENTRYPOINT ["python", "switchmate.py"]