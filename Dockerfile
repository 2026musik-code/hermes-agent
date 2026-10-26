FROM docker.io/library/python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends git ca-certificates \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir hermes-agent aiohttp

ENV HERMES_HOME=/data/.hermes
RUN mkdir -p /data/.hermes && chmod -R 777 /data

COPY config.yaml /data/.hermes/config.yaml
COPY start.sh /usr/local/bin/start.sh
RUN chmod +x /usr/local/bin/start.sh

ENV API_SERVER_ENABLED=true
ENV API_SERVER_HOST=0.0.0.0
EXPOSE 8642

CMD ["/bin/sh", "/usr/local/bin/start.sh"]
