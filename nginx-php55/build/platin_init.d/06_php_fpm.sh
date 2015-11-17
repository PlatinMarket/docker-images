#!/usr/bin/env bash

APPNAME=${APPNAME:-$HOSTNAME}

# Get Tags
IFS=', ' read -r -a array <<< "$TAG"

# For each tag
for tag in "${array[@]}"
do
  # checking sites-enabled dir
  if [ -e $BASEFOLDER/$tag/php-conf ]; then
    echo "Adding php-conf files from $BASEFOLDER/$tag/php-conf to /etc/php5/fpm/conf.d/"
    cp -rf $BASEFOLDER/$tag/php-conf/* /etc/php5/fpm/conf.d/
  fi
done

# Restart php5 service, if it exists.
if [ -e /etc/service/php/run ]; then
  echo "Reloading php5-fpm."
  killall php5-fpm
fi