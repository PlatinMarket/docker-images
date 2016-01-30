#!/usr/bin/env bash
rm -rf /var/www/* && toolbox git_clone https://github.com/PlatinMarket/platinmarket-www-root.git /var/www/platinmarket-www-root
chown -R www-data:www-data /var/www/platinmarket-www-root && chmod -R 775 /var/www/platinmarket-www-root
