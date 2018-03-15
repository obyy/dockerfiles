#!/bin/sh
set -ei
UID=${UID:-9001}
#adduser -D -u ${UID} obyy || true
useradd -u ${UID:-9001} obyy
chown -R obyy:obyy /opt
chown -R obyy:obyy /config

if [ "$#" = "0" ]; then
  exec gosu obyy mono /opt/Jackett/JackettConsole.exe --NoUpdates "${RUN_OPTS}"
else
  exec $@
fi
