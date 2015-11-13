# Use phusion/baseimage as base image. To make your builds reproducible, make
# https://github.com/phusion/baseimage-docker
FROM phusion/baseimage:0.9.17

# Enable SSH
RUN rm -f /etc/service/sshd/down

# Add config folder
ADD config /config

# Add authorized ssh clients folder
RUN mkdir -p /config/authorized_keys

# Add init scripts
ADD init_script/*.sh /etc/my_init.d/
RUN chmod +x /etc/my_init.d/*

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# Update apt cache & Install python-software-properties
RUN add-apt-repository ppa:nginx/stable
RUN apt-get update && apt-get install -y git nginx

# Redirect stderr to log stderr
RUN ln -sf /dev/stderr /var/log/stderr.log

# Add nginx daemon script
RUN mkdir -p /etc/service/nginx
ADD daemon/nginx.sh /etc/service/nginx/run
RUN chmod +x /etc/service/nginx/run

# Git clone
RUN sh /config/git_clone.sh

# Bind 80 Port
EXPOSE 80

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
