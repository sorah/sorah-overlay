# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# Fork from https://github.com/csmk/frabjous/blob/master/net-libs/wslay

EAPI=6
RESTRICT="mirror"

inherit autotools

MY_P="${PN}-release-${PV}"

DESCRIPTION="The WebSocket library written in C"
HOMEPAGE="https://tatsuhiro-t.github.io/wslay/"
SRC_URI="https://github.com/tatsuhiro-t/${PN}/archive/release-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/sphinx"

DOCS=( AUTHORS COPYING NEWS README.rst )

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default
	eautoreconf
}
