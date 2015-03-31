###
# kubernetes system config
#
# The following values are used to configure various aspects of all
# kubernetes services, including
#
#   kube-apiserver.service
#   kube-controller-manager.service
#   kube-scheduler.service
#   kubelet.service
#   kube-proxy.service

# Comma seperated list of nodes in the etcd cluster
KUBE_ETCD_SERVERS="--etcd_servers=http://127.0.0.1:4001"

# Comma seperated list of api servers in the etcd cluster
KUBE_API_SERVERS="--api_servers=http://127.0.0.1:8080"
KUBE_MASTER="--master=http://127.0.0.1:8080"

# logging to /var/log/kubernetes
KUBE_LOG="--log_dir=/var/log/kubernetes"

# journal message level, 0 is debug
KUBE_LOG_LEVEL="--v=0"

# Should this cluster be allowed to run privleged docker containers
KUBE_ALLOW_PRIV="--allow_privileged=false"
