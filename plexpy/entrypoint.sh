#!/bin/sh
set -ei
UID=${UID:-9001}
adduser -D -u ${UID} obyy || true

chown -R obyy:obyy /opt
chown -R obyy:obyy /config

if [ "$#" = "0" ]; then
  exec su-exec obyy python /opt/PlexPy.py --datadir /config
else
  exec $@
fi

