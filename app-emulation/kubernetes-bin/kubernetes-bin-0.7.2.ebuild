# Copyright 2015 Shota Fukumori (sora_h) <her@sorah.jp>
# Distributed under the terms of the MIT License
# $Header: $

EAPI=5

inherit user

DESCRIPTION="Container Cluster Manager"
HOMEPAGE="https://github.com/GoogleCloudPlatform/kubernetes"
SRC_URI="https://github.com/GoogleCloudPlatform/kubernetes/releases/download/v${PV}/kubernetes.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* amd64"
IUSE="master kubelet"

DEPEND="master? ( dev-db/etcd )
        kubelet? ( dev-db/etcd app-emulation/docker net-analyzer/cadvisor-bin )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/kubernetes"

src_prepare() {
	if use master || use kubelet ; then
		tar xfv server/kubernetes-server-linux-amd64.tar.gz
	fi
}

src_install() {
	if use master || use kubelet ; then
		kube_components=""
		if use master; then
			kube_components="${kube_components} kube-apiserver kube-controller-manager kube-scheduler"
		fi
		if use kubelet; then
			kube_components="${kube_components} kubelet kube-proxy"
		fi

		cd kubernetes/server/bin
		dobin kubecfg kubectl kubernetes
		dobin ${kube_components}

		newconfd "${FILESDIR}/kubernetes.conf.d" kubernetes


		for x in ${kube_components}; do
			newconfd "${FILESDIR}/${x}.conf.d" ${x}
			newinitd "${FILESDIR}/${x}.init.d" ${x}
		done
	else
		cd platforms/linux/amd64
		dobin kubecfg kubectl kubernetes
	fi
}

pkg_postinst() {
	if use master || use kubelet ; then
		enewuser kube
	fi
}
