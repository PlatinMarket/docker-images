#!/usr/bin/env bash
echo "Installing php-zookeeper extension"

cd /root && git clone https://github.com/andreiz/php-zookeeper.git php-zookeeper

cd /root/php-zookeeper
phpize
./configure
make && make install
echo "extension=zookeeper.so" > /etc/php5/mods-available/zookeeper.ini
ln -s /etc/php5/mods-available/zookeeper.ini /etc/php5/fpm/conf.d/zookeeper.ini
ln -s /etc/php5/mods-available/zookeeper.ini /etc/php5/cli/conf.d/zookeeper.ini

rm -rf /root/php-zookeeper
