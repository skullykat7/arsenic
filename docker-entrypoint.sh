#!/bin/sh

set -e

# environment variables are set at runtime, so modify the conf only when it starts

if [ ! -z "$SAFE_BROWSING" ]; then
    sed -i "s/1.1.1.1/1.1.1.3/" /etc/nginx/nginx.conf
fi

# Make nginx listen on the PORT that Hostless (or Heroku) gives us
sed -i "s/listen 80;/listen ${PORT:-80};/" /etc/nginx/nginx.conf

# default.conf makes docker listen to 80, and
# non-root users won't like it
rm -f /etc/nginx/conf.d/default.conf

# daemon off; was already injected by docker-sed.sh at build time
exec nginx
