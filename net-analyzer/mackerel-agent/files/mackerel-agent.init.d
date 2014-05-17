#!/sbin/runscript
# Copyright 2014 Shota Fukumori (sora_h) <her@sorah.jp>
# Distributed under the terms of the MIT License
# $Header: $

LOGFILE=${LOGFILE:-/var/log/mackerel-agent.log}
pidfile=${PIDFILE:-/var/run/mackerel-agent.pid}
CONFIG=${CONFIG:-/etc/mackerel-agent/mackerel-agent.conf}
ROOT=${ROOT:-/var/lib/mackerel-agent}

if [ -n "$BASIC" ]; then
  APIBASE=${APIBASE:="https://${BASIC}@mackerel.io"}
else
  APIBASE=${APIBASE:="https://mackerel.io"}
fi

command=/usr/bin/mackerel-agent
command_args="--apibase=$APIBASE --conf=$CONFIG --pidfile=$pidfile"
command_background=true
start_stop_daemon_args="-1 ${LOGFILE} -2 ${LOGFILE}"
