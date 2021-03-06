# Use phusion/baseimage as base image. To make your builds reproducible, make
# https://github.com/phusion/baseimage-docker
FROM platinmarket/baseimage:latest

# Environment
ENV TAG=all,webserver,loadbalancer,nginx

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

# Bind HTTP, HTTPS, SSL
EXPOSE 80 443

# Expose our data, log, and configuration directories.
VOLUME ["/mnt/base", "/var/log"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /build
