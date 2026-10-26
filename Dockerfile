FROM docker.io/nousresearch/hermes-agent:latest
COPY config.yaml /opt/hermes/cli-config.yaml.example
CMD ["/bin/sh","-c","id; echo HOME=$HOME; ls -ld /opt/data; mkdir -p /tmp/httproot && cd /tmp/httproot && exec python3 -m http.server 8642"]
