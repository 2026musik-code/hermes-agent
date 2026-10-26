# Aiven application-service deploy: official image + gateway as main process
FROM docker.io/nousresearch/hermes-agent:latest

# Bake default model config (seeded to ~/.hermes/config.yaml on first boot)
COPY config.yaml /opt/hermes/cli-config.yaml.example

# Run the messaging gateway as the container's main process
CMD ["gateway", "run"]
