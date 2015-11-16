# Use phusion/baseimage as base image. To make your builds reproducible, make
# https://github.com/phusion/baseimage-docker
FROM platinmarket/baseimage:latest

# Environment
ENV TAG=all,webserver,appserver,php,php56
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
RUN apt-get update && apt-get install -y nginx

# Git clone www_root
RUN /build/clone_www_root.sh

# Run nginx config
RUN /build/config_nginx.sh

# Installing PHP
RUN apt-get install -y php5-fpm php5 php5-curl php5-gd php5-intl php5-mcrypt php5-imagick php5-xmlrpc php5-sqlite php5-redis php5-pgsql php5-oauth php5-mysql php5-mongo php5-ldap php5-json php5-geoip php5-cli

# Run php config
RUN /build/config_php.sh

# Bind HTTP, HTTPS, SSL
EXPOSE 80 443

# Expose our data, log, and configuration directories.
VOLUME ["/var/www/web-app", "/mnt/base", "/var/log"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /build
