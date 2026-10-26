#!/bin/sh
# Copy platform-injected env secrets into $HERMES_HOME/.env so hermes's
# scoped-secret reader can see them, then exec the gateway.
ENVF="${HERMES_HOME:-/data/.hermes}/.env"
mkdir -p "$(dirname "$ENVF")"
touch "$ENVF" && chmod 600 "$ENVF"
for V in API_SERVER_KEY OPENAI_API_KEY TELEGRAM_BOT_TOKEN OPENAI_BASE_URL API_SERVER_HOST API_SERVER_ENABLED; do
  eval "VAL=\${$V}"
  if [ -n "$VAL" ] && ! grep -q "^$V=" "$ENVF"; then
    printf '%s=%s\n' "$V" "$VAL" >> "$ENVF"
  fi
done
exec hermes gateway run
