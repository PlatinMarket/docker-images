# Use phusion/baseimage as base image. To make your builds reproducible, make
# https://github.com/phusion/baseimage-docker
FROM platinmarket/baseimage:latest

# Environment
ENV TAG=all,database,sql,mysql,mysql55

# create data dir
RUN mkdir /data

# Add build folder
ADD build /build
RUN chmod +x /build/*

# Add first run flag
RUN touch /firstrun

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Update apt cache & Install nginx
RUN apt-get update && apt-get install -y mysql-client mysql-server pwgen inotify-tools

# Config mysql
RUN /build/config_mysql.sh

# Bind 80 Port
EXPOSE 3306

# Expose our data, log, and configuration directories.
VOLUME ["/data", "/var/log"]

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /build
