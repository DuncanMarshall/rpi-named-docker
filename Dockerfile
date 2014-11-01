FROM resin/rpi-raspbian:latest

MAINTAINER marc.lennox@gmail.com

# Set environment.
ENV DEBIAN_FRONTEND noninteractive

# Install packages.
RUN apt-get update
RUN apt-get -y upgrade
#RUN apt-get -y dist-upgrade
RUN apt-get install -y bind9 dnsutils

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Move the existing configuration and data directories out of the way
RUN mv /etc/bind /etc/bind.orig
RUN mv /var/lib/bind /var/lib/bind.orig

# Define working directory.
WORKDIR /opt/named

# Add files to the container.
ADD . /opt/named

# Define volumes.
VOLUME ["/etc/bind", "/var/lib/bind", "/var/run/named"]

# Expose ports.
EXPOSE 53
EXPOSE 53/udp

# Define entrypoint.
ENTRYPOINT ["./entrypoint"]

# Define command
CMD ["/usr/sbin/named", "-u", "bind", "-g"]
