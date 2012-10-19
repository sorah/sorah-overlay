# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils

DESCRIPTION="ARIB STD-B25 test implementation for understanding specs"
HOMEPAGE="http://www.marumo.ne.jp/db2008_c.htm#30"
SRC_URI="http://hg.honeyplanet.jp/pt1/archive/c44e16dbb0e2.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE=""

DEPEND="virtual/pkgconfig"
RDEPEND="${DEPEND}"

S=${WORKDIR}/pt1-c44e16dbb0e2

src_prepare() {
	cd ${WORKDIR}/pt1-c44e16dbb0e2/arib25/src
	epatch "${FILESDIR}/${PV}/fix-bin-install.diff"
	epatch "${FILESDIR}/${PV}/disable-ldconfig.diff"
}

src_compile() {
	cd ${WORKDIR}/pt1-c44e16dbb0e2/arib25
	emake
}

src_install() {
	cd ${WORKDIR}/pt1-c44e16dbb0e2/arib25
	mkdir -p ${D}/usr/local/{lib,bin}
	emake PREFIX="${D}/usr/local" install
}
