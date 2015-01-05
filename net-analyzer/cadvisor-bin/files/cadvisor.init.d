#!/sbin/runscript
# Copyright 2014 Shota Fukumori (sora_h) <her@sorah.jp>
# Distributed under the terms of the MIT License
# $Header: $

command="/usr/bin/cadvisor"
command_args="${CADVISOR_LISTEN} ${CADVISOR_PORT} ${CADVISOR_STORAGE} ${CADVISOR_LOG} ${CADVISOR_ARGS}"
command_background=yes
pidfile=/var/run/cadvisor.pid

depend() {
	use net
}

start_pre() {
	checkpath --directory --owner root:root --mode 0755 /var/log/cadvisor
}
