# default config should be adequate
. /etc/conf.d/kubernetes

# The address for the info server to serve on (set to 0.0.0.0 or "" for all interfaces)
KUBELET_ADDRESS="--address=127.0.0.1"

# The port for the info server to serve on
KUBELET_PORT="--port=10250"

# You may leave this blank to use the actual hostname
KUBELET_HOSTNAME="--hostname_override=127.0.0.1"

# Add your own!
KUBELET_ARGS=""
