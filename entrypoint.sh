#!/bin/bash
set -e

# Copy a default configuration into place if one is not there
if ! [ -f /etc/bind/named.conf ]; then
  cp -f /etc/bind.orig/named.conf.authoritative /etc/bind/named.conf
  cp /etc/bind.orig/bind.keys /etc/bind/bind.keys
fi

exec "$@"
