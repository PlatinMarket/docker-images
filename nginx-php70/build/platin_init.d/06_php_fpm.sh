#!/usr/bin/env bash

# Cleanup previous sockets
if [ -e /run/php/php7.0-fpm.sock ]; then
  rm -f /run/php/php7.0-fpm.sock 2> /dev/null
fi
if [ -e /run/php/php7.0-fpm.pid ]; then
  rm -f /run/php/php7.0-fpm.pid 2> /dev/null
fi

if [ ! -f /run/php/php7.0-fpm.sock ]; then
    touch /run/php/php7.0-fpm.sock
    chmod 777 /run/php/php7.0-fpm.sock
fi
if [ ! -f /run/php/php7.0-fpm.pid]; then
    touch /run/php/php7.0-fpm.pid
    chmod 777 /run/php/php7.0-fpm.pid
fi

APPNAME=${APPNAME:-$HOSTNAME}

# Get Tags
IFS=', ' read -r -a array <<< "$TAG"

# For each tag
for tag in "${array[@]}"
do
  # checking sites-enabled dir
  if [ -e $BASEFOLDER/$tag/php-conf ]; then
    echo "Adding php-conf files from $BASEFOLDER/$tag/php-conf to /etc/php/7.0/fpm/conf.d/"
    cp -rf $BASEFOLDER/$tag/php-conf/* /etc/php/7.0/fpm/conf.d/
  fi
done

# Restart php5 service, if it exists.
if [ -e /etc/service/php/run ]; then
  echo "Reloading php7.0-fpm."
  killall php7.0-fpm
fi
