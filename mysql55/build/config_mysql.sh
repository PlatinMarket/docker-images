#!/usr/bin/env bash

echo "Installing mysql run scripts."
mkdir -p /etc/service/mysql
cp /build/daemon/mysql.sh /etc/service/mysql/run
chmod +x /etc/service/mysql/run

echo "Copy mysql config."
if [ ! -d /etc/mysql/conf.d ]; then
  mkdir -p /etc/mysql/conf.d
fi
cp /build/config/*.cnf /etc/mysql/conf.d/
chown mysql /etc/mysql/conf.d/*.cnf

echo "Setting up mysql."
sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
sed -i -e 's/^datadir\s*=.*/datadir = \/data/' /etc/mysql/my.cnf
