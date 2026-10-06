FROM python:3.12-alpine3.20

WORKDIR /app

RUN apk add --no-cache \
    ffmpeg \
    jq \
    python3-dev \
    gcc \
    musl-dev \
    libffi-dev \
    openssl-dev \
    curl \
    unzip \
    deno

RUN deno --version

COPY requirements.txt .

RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY . .

RUN yt-dlp --version && \
    ffmpeg -version && \
    python3 -m pip check

CMD ["python3", "bot.py"]
