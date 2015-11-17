#!/usr/bin/env bash

echo "Installing nginx run scripts."
mkdir -p /etc/service/nginx
cp /build/daemon/nginx.sh /etc/service/nginx/run
chmod +x /etc/service/nginx/run

echo "Setting up nginx."
cp /build/config/nginx.conf /etc/nginx/nginx.conf

echo "Setting up nginx sites-enabled folder."
rm -rf /etc/nginx/sites-enabled/* && cp -rf /build/config/sites-enabled/* /etc/nginx/sites-enabled/
