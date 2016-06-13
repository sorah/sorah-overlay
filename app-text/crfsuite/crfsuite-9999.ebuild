# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit git-r3 autotools

DESCRIPTION="a fast implementation of Conditional Random Fields (CRFs)"
HOMEPAGE="https://github.com/chokkan/crfsuite"
EGIT_REPO_URI="https://github.com/chokkan/crfsuite"

LICENSE="BSD-3"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="sci-libs/liblbfgs"
RDEPEND="${DEPEND}"

src_prepare() {
	eautoreconf
	eapply_user
}
