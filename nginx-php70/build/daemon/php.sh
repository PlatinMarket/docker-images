#!/usr/bin/env bash

# Check if sock not created
if [ ! -f /run/php/php7.0-fpm.sock ]; then
    mkdir /run/php/
    touch /run/php/php7.0-fpm.sock
    chmod 777 /run/php/php7.0-fpm.sock
fi

# Php 5 fpm daemon
/usr/sbin/php-fpm7.0 -c /etc/php/7.0/fpm
