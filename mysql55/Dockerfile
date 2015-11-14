# Use phusion/baseimage as base image. To make your builds reproducible, make
# https://github.com/phusion/baseimage-docker
FROM platinmarket/baseimage:latest

# Environment
ENV TAG=all,database,sql,mysql,mysql55

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

# Bind 80 Port
EXPOSE 80

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /build
