#!/usr/bin/env bash
echo "Setting up nginx."
cat /config/nginx/mime.types > /etc/nginx/mime.types
cat /config/nginx/nginx.conf > /etc/nginx/nginx.conf
cp /config/nginx/conf.d/* /etc/nginx/conf.d/
rm /etc/nginx/sites-enabled/default && cp /config/nginx/sites-enabled/* /etc/nginx/sites-enabled/
