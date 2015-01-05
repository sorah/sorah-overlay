#!/sbin/runscript

command="/usr/bin/kube-proxy"
command_args="${KUBE_LOG} ${KUBE_LOG_LEVEL} ${KUBE_ETCD_SERVERS} ${KUBE_PROXY_ARGS}"
command_background=1
start_stop_daemon_args="-1 /var/log/kubernetes/kube-proxy.log -2 /var/log/kubernetes/kube-proxy.log"
pidfile=/var/run/kubernetes/kube-proxy.pid

depend() {
	use net
}

start_pre() {
	checkpath --directory --owner root:kube --mode 0775 /var/log/kubernetes
	checkpath --directory --owner root:root --mode 0755 /var/run/kubernetes
}

