#!/usr/bin/env bash

# check nginx log folder
if [ ! -d /var/log/nginx ]; then
  mkdir -p /var/log/nginx 2> /dev/null
  chown -R www-data:www-data /var/log/nginx
  chmod -R 775 /var/log/nginx
fi

nginx
