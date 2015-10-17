FROM hypriot/rpi-alpine-scratch:latest

MAINTAINER marc.lennox@gmail.com

# Set environment variables.
ENV \
  TERM=xterm-color

# Install packages.
RUN apk update && \
    apk upgrade && \
    apk add bash bind nano wget && \
    rm -rf /var/cache/apk/*

# Move the existing configuration and data directories out of the way
RUN mv /etc/bind /etc/bind.orig

# Add files to the container.
COPY entrypoint.sh /docker-entrypoint

# Define volumes.
VOLUME ["/etc/bind", "/var/lib/bind", "/var/run/named"]

# Expose ports.
EXPOSE 53
EXPOSE 53/udp

# Define entrypoint.
ENTRYPOINT ["/docker-entrypoint"]

# Define command
CMD ["/usr/sbin/named", "-g"]
