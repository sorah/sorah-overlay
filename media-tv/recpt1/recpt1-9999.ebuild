# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils mercurial autotools

DESCRIPTION="(^o^)/"
HOMEPAGE="http://hg.honeyplanet.jp/pt1/"
EHG_REPO_URI="http://hg.honeyplanet.jp/pt1/"

LICENSE=""
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE="b25"

DEPEND="virtual/pkgconfig
        b25? ( media-tv/arib25 )"
RDEPEND="${DEPEND}"

src_prepare() {
	cd ${S}/recpt1
	eaclocal -I .
	eautoheader
	eautoconf
}

src_configure() {
	cd ${S}/recpt1
	econf $(use_enable b25) --prefix=/usr/local
}

src_compile() {
	cd ${S}/recpt1
	emake
}

src_install() {
	cd ${S}/recpt1
	mkdir -p ${D}/usr/local/bin
	emake DESTDIR="${D}" install
}
