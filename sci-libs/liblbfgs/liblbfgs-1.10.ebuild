# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit autotools

DESCRIPTION="a library of Limited-memory Broyden-Fletcher-Goldfarb-Shanno (L-BFGS)"
HOMEPAGE="http://www.chokkan.org/software/liblbfgs"
SRC_URI="https://github.com/chokkan/${PN}/archive/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	touch INSTALL
	eautoreconf
	eapply_user
}
