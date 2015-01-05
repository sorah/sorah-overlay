# Copyright 2014 Shota Fukumori (sora_h) <her@sorah.jp>
# Distributed under the terms of the MIT License
# $Header: $

EAPI=5

DESCRIPTION="Analyzes resource usage and performance characteristics of running containers"
HOMEPAGE="https://github.com/google/cadvisor"
SRC_URI="https://github.com/google/cadvisor/releases/download/${PV}/cadvisor"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="-* amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_unpack() {
	cp ${DISTDIR}/${A} "${WORKDIR}/"
}

src_install() {
	dobin cadvisor
	newconfd "${FILESDIR}/cadvisor.conf.d" cadvisor
	newinitd "${FILESDIR}/cadvisor.init.d" cadvisor
}
