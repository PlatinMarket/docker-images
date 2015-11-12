#!/usr/bin/env bash
echo "Cloning PlatinMarket/platinmarket-www-root to /var/www."
rm -rf /var/www && git clone https://github.com/PlatinMarket/platinmarket-www-root.git /var/www
echo "Changing permission /var/www to www-data."
chown -vfR www-data:www-data /var/www
chmod -vfR 775 /var/www
echo "cd /var/www && sudo -u www-data git reset --hard && sudo -u www-data git pull" >> /config/git_pull.sh
