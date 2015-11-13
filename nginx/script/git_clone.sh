#!/usr/bin/env bash
echo "Cloning https://github.com/PlatinMarket/docker-images.git to /docker-images"
rm -rf /var/www && git clone https://github.com/PlatinMarket/docker-images.git  /docker-images
echo "cd /docker-images && git reset --hard && git pull" >> /config/git_pull.sh
