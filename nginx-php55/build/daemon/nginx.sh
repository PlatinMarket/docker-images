#!/usr/bin/env bash

ROOTDIR=/var/www/web-app/public

# check nginx log folder
if [ ! -d /var/log/nginx ]; then
  mkdir -p /var/log/nginx 2> /dev/null
  chown -R www-data:www-data /var/log/nginx
  chmod -R 775 /var/log/nginx
fi

if [ ! -d $ROOTDIR ]; then
  mkdir -p $ROOTDIR
  chown -R www-data:www-data /var/www
  chmod -R 775 /var/www
fi

# test if DATA_DIR has content
if [[ ! "$(ls -A $ROOTDIR)" ]]; then
  echo "Initializing root at $DATA_DIR"
  cp -R /var/www/platinmarket-www-root/public/* $ROOTDIR/
  echo "<?php phpinfo(); ?>" > $ROOTDIR/index.php
fi

nginx
