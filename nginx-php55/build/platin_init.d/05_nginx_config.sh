#!/usr/bin/env bash

APPNAME=${APPNAME:-$HOSTNAME}

# Get Tags
IFS=', ' read -r -a array <<< "$TAG"

# For each tag
for tag in "${array[@]}"
do
  # checking sites-enabled dir
  if [ -e $BASEFOLDER/$tag/sites-enabled ]; then
    echo "Adding sites-enabled files from $BASEFOLDER/$tag/sites-enabled to /etc/nginx/sites-enabled"
    cp -rf $BASEFOLDER/$tag/sites-enabled/* /etc/nginx/sites-enabled/
    chown -R www-data:www-data /etc/nginx 2> /dev/null
    chmod -R 775 /etc/nginx 2> /dev/null
  fi
done

if [ -e $BASEFOLDER/$APPNAME/nginx.conf ]; then
  echo "Adding site-config from $BASEFOLDER/$APPNAME/nginx.conf  to /etc/nginx/sites-enabled"
  cp -f $BASEFOLDER/$APPNAME/nginx.conf /etc/nginx/sites-enabled/default
  chown -R www-data:www-data /etc/nginx 2> /dev/null
  chmod -R 775 /etc/nginx 2> /dev/null
fi

# Restart nginx service, if it exists.
if [ -e /etc/service/nginx/run ]; then
  echo "Reloading nginx."
  killall nginx
  sleep 1s
fi
