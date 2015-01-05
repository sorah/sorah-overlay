# defaults from config and apiserver should be adequate
. /etc/conf.d/kubernetes
. /etc/conf.d/kube-apiserver

# Comma seperated list of minions
KUBELET_ADDRESSES="--machines=127.0.0.1"

# Add you own!
KUBE_CONTROLLER_MANAGER_ARGS=""
