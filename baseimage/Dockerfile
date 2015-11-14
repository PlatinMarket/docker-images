# Use phusion/baseimage as base image. To make your builds reproducible, make
# https://github.com/phusion/baseimage-docker
FROM phusion/baseimage:0.9.17

# Make mount point
RUN mkdir -p /mnt/base

# Change repository country to nearest
RUN sudo sed -i 's/http:\/\//http:\/\/tr./g' /etc/apt/sources.list

# Environment
ENV TOOLBOXFOLDER=/docker-toolbox
ENV BASEFOLDER=/mnt/base
ENV TAG=all

# Enable SSH
RUN rm -f /etc/service/sshd/down

# Add build folder
ADD build /build
RUN chmod +x /build/*

# Run build scripts
RUN /build/prepare.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Update apt cache & Install git
RUN apt-get update && apt-get upgrade -y && apt-get autoclean && apt-get install -y git ntp

# Git clone
RUN /build/clone_docker_toolbox.sh

# Config ntp client
RUN /build/config_ntp.sh

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /build
