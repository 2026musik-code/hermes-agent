FROM docker.io/library/python:3.12-slim

# Runtime deps hermes butuh git + build tools minimal
RUN apt-get update && apt-get install -y --no-install-recommends git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Install hermes-agent dari PyPI
RUN pip install --no-cache-dir hermes-agent

# Fixed data dir (writable oleh UID acak platform)
ENV HERMES_HOME=/data/.hermes
RUN mkdir -p /data/.hermes && chmod -R 777 /data

# Config default model (custom provider endpoint)
COPY config.yaml /data/.hermes/config.yaml

# API server gateway (health-check platform)
ENV API_SERVER_ENABLED=true
ENV API_SERVER_HOST=0.0.0.0
EXPOSE 8642

# Jalankan messaging gateway (Telegram long-polling)
CMD ["hermes", "gateway", "run"]
