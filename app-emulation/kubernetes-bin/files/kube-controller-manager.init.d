#!/sbin/runscript

command="/usr/bin/kube-controller-manager"
command_args="${KUBE_LOG} ${KUBE_LOG_LEVEL} ${KUBELET_ADDRESSES} ${KUBE_MASTER} ${KUBE_CONTROLLER_MANAGER_ARGS}"
start_stop_daemon_args="-1 /var/log/kubernetes/kube-controller-manager.log -2 /var/log/kubernetes/kube-controller-manager.log --user kube"
command_background=1
pidfile=/var/run/kubernetes/kube-controller-manager.pid

depend() {
	use net
}

start_pre() {
	checkpath --directory --owner root:kube --mode 0775 /var/log/kubernetes
	checkpath --directory --owner root:root --mode 0755 /var/run/kubernetes
}

