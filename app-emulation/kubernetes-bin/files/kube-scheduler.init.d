#!/sbin/runscript

command="/usr/bin/kube-scheduler"
command_args="${KUBE_LOG} ${KUBE_LOG_LEVEL} ${KUBE_MASTER} ${KUBE_SCHEDULER_ARGS}"
start_stop_daemon_args="--user kube -1 /var/log/kubernetes/kube-scheduler.log -2 /var/log/kubernetes/kube-scheduler.log"
command_background=1
pidfile=/var/run/kubernetes/kube-scheduler.pid

depend() {
	use net
}

start_pre() {
	checkpath --directory --owner root:kube --mode 0775 /var/log/kubernetes
	checkpath --directory --owner root:root --mode 0755 /var/run/kubernetes
}


