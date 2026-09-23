#!/bin/sh

set -e

# change public dir to appropriate path
sed -i "s/\/home\/binary\/womginx\/public/\/opt\/womginx\/public/g" nginx.conf

# disable ssl (since we're running this behind a reverse proxy)
sed -i '/ssl_certificate/d' nginx.conf
sed -i '/listen 443/d' nginx.conf

# Make the listen port use the $PORT environment variable
sed -i 's/listen 80;/listen ${PORT};/' nginx.conf

# prevent reverse proxy headers from being sent to destination site
sed -i $"s/proxy_set_header Accept-Encoding/proxy_set_header x-request-id '';\
proxy_set_header x-forwarded-for '';\
proxy_set_header x-forwarded-proto '';\
proxy_set_header x-forwarded-port '';\
proxy_set_header via '';\
proxy_set_header connect-time '';\
proxy_set_header x-request-start '';\
proxy_set_header total-route-time '';\
proxy_set_header Accept-Encoding/" nginx.conf

# use x-forwarded-for instead of remote client ip
sed -i "s/binary_remote_addr/http_x_forwarded_for/g" nginx.conf

# pipe logs to stdout/stderr
sed -i 's/http {/http {access_log \/dev\/stdout; error_log stderr;/' nginx.conf

# disable daemon mode for nginx
sed -i '1i daemon off;' nginx.conf
