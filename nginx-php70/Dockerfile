# Use phusion/baseimage as base image. To make your builds reproducible, make
# https://github.com/phusion/baseimage-docker
FROM platinmarket/baseimage:latest

# Environment
ENV TAG=all,webserver,appserver,php,php70
ENV DEBUG=off

# Add build folder
ADD build /build
RUN chmod +x /build/*

# Run build scripts
RUN /build/prepare.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Update apt cache & Install nginx
RUN add-apt-repository ppa:nginx/stable
RUN LC_ALL=en_US.UTF-8 add-apt-repository ppa:ondrej/php
RUN apt-get update && apt-get install -y nginx

# Git clone www_root
RUN /build/clone_www_root.sh

# Run nginx config
RUN /build/config_nginx.sh

# Installing PHP
RUN apt-get install -y unzip zip php7.0-fpm php7.0 php7.0-xml php7.0-gmp php7.0-zip php7.0-curl php7.0-mbstring php7.0-gd php7.0-intl php7.0-mcrypt php-imagick php-redis php7.0-xmlrpc php7.0-sqlite3 php7.0-pgsql php7.0-mysql php7.0-ldap php7.0-json php7.0-cli

# Run php config
RUN /build/config_php.sh

# Install composer
RUN /build/install_composer.sh

# Bind HTTP, HTTPS, SSL
EXPOSE 80 443

# Expose our data, log, and configuration directories.
VOLUME ["/var/www/web-app", "/mnt/base", "/var/log"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /build
