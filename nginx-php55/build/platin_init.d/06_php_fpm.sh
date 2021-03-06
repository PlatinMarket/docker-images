#!/usr/bin/env bash

# Cleanup previous sockets
if [ -e /var/run/php5-fpm.sock ]; then
  rm -f /var/run/php5-fpm.sock 2> /dev/null
fi
if [ -e /var/run/php5-fpm.pid ]; then
  rm -f /var/run/php5-fpm.pid 2> /dev/null
fi

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

  if [ -e $BASEFOLDER/$APPNAME/php-conf ]; then
    echo "Adding php-conf files from $BASEFOLDER/$APPNAME/php-conf to /etc/php5/fpm/conf.d/"
    cp -rf $BASEFOLDER/$APPNAME/php-conf/* /etc/php5/fpm/conf.d/
  fi
done

if [ -f $BASEFOLDER/$APPNAME/www.conf ]; then
  echo "Adding www.conf file from $BASEFOLDER/$APPNAME/www.conf to /etc/php5/fpm/pool.d/www.conf"
  cp -f $BASEFOLDER/$APPNAME/www.conf /etc/php5/fpm/pool.d/www.conf
fi

# Restart php5 service, if it exists.
if [ -e /etc/service/php/run ]; then
  echo "Reloading php5-fpm."
  killall php5-fpm
fi
