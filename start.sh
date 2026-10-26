#!/bin/sh
# Sync platform-injected env secrets into $HERMES_HOME/.env (overwrite mode)
# so hermes's scoped-secret reader always sees the CURRENT values.
ENVF="${HERMES_HOME:-/data/.hermes}/.env"
mkdir -p "$(dirname "$ENVF")"
touch "$ENVF" && chmod 600 "$ENVF"
for V in API_SERVER_KEY OPENAI_API_KEY TELEGRAM_BOT_TOKEN OPENAI_BASE_URL API_SERVER_HOST API_SERVER_ENABLED; do
  eval "VAL=\${$V}"
  [ -z "$VAL" ] && continue
  sed -i "/^$V=/d" "$ENVF" 2>/dev/null
  printf '%s=%s\n' "$V" "$VAL" >> "$ENVF"
done
exec hermes gateway run
