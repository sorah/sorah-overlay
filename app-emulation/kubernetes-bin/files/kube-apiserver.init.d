#!/sbin/runscript

command="/usr/bin/kube-apiserver"
command_args="${KUBE_LOG} ${KUBE_LOG_LEVEL} ${KUBE_ETCD_SERVERS} ${KUBE_API_ADDRESS} ${KUBE_API_PORT} ${KUBELET_PORT} ${KUBE_ALLOW_PRIV} ${KUBE_SERVICE_ADDRESSES} ${KUBE_API_ARGS}"
start_stop_daemon_args="-1 /var/log/kubernetes/kube-apiserver.log -2 /var/log/kubernetes/kube-apiserver.log --user kube"
command_background=1
pidfile=/var/run/kubernetes/kube-apiserver.pid

depend() {
	use net
}

start_pre() {
	checkpath --directory --owner root:kube --mode 0775 /var/log/kubernetes
	checkpath --directory --owner kube:root --mode 0775 /var/run/kubernetes
}
