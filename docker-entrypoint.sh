#!/bin/sh
set -e

# Optional Safe Browsing (only if the env var is set)
if [ -n "$SAFE_BROWSING" ]; then
  sed -i "s/1.1.1.1/1.1.1.3/" /etc/nginx/nginx.conf
fi

# Remove the default config that the official nginx image ships
rm -f /etc/nginx/conf.d/default.conf

# Substitute ${PORT} and start nginx
envsubst '${PORT}' < /etc/nginx/nginx.conf > /tmp/nginx.conf
mv /tmp/nginx.conf /etc/nginx/nginx.conf

exec nginx
