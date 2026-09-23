#!/bin/sh
set -e

# Optional Safe Browsing
if [ -n "$SAFE_BROWSING" ]; then
  sed -i "s/1.1.1.1/1.1.1.3/" /etc/nginx/nginx.conf
fi

# Substitute the PORT variable and start nginx
envsubst '${PORT}' < /etc/nginx/nginx.conf > /tmp/nginx.conf \
  && cat /tmp/nginx.conf > /etc/nginx/nginx.conf

exec nginx
