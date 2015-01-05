#!/sbin/runscript

command="/usr/bin/kubelet"
command_args="${KUBE_LOG} ${KUBE_LOG_LEVEL} ${KUBE_ETCD_SERVERS} ${KUBELET_ADDRESS} ${KUBELET_PORT} ${KUBELET_HOSTNAME} ${KUBE_ALLOW_PRIV} ${KUBELET_ARGS}"
command_background=1
start_stop_daemon_args="-1 /var/log/kubernetes/kubelet.log -2 /var/log/kubernetes/kubelet.log"
pidfile=/var/run/kubernetes/kubelet.pid

depend() {
	use net docker cadvisor
}

start_pre() {
	checkpath --directory --owner root:kube --mode 0775 /var/log/kubernetes
	checkpath --directory --owner root:root --mode 0755 /var/run/kubernetes
}



