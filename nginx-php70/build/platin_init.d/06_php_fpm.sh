#!/usr/bin/env bash

# Check if sock not created
if [ ! -e /run/php/php7.0-fpm.sock ]; then
    mkdir /run/php/
    touch /run/php/php7.0-fpm.sock
    chmod 777 /run/php/php7.0-fpm.sock
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

if [ -e $BASEFOLDER/$APPNAME/php-conf ]; then
  echo "Adding php-conf files from $BASEFOLDER/$APPNAME/php-conf to /etc/php/7.0/fpm/conf.d/"
  cp -rf $BASEFOLDER/$APPNAME/php-conf/* /etc/php/7.0/fpm/conf.d/
fi

if [ -f $BASEFOLDER/$APPNAME/www.conf ]; then
  echo "Adding www.conf file from $BASEFOLDER/$APPNAME/www.conf to /etc/php/7.0/fpm/pool.d/www.conf"
  cp -f $BASEFOLDER/$APPNAME/www.conf /etc/php/7.0/fpm/pool.d/www.conf
fi

# Restart php5 service, if it exists.
if [ -e /etc/service/php/run ]; then
  echo "Reloading php-fpm7.0."
  killall php-fpm7.0
fi
