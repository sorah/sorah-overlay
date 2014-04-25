# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit autotools eutils git-2

DESCRIPTION="ACCELerate TCP proxy"
HOMEPAGE="https://github.com/KLab/AccelTCP"
EGIT_REPO_URI="https://github.com/Klab/AccelTCP"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-libs/libev dev-libs/openssl"
RDEPEND="${DEPEND}"


src_install() {
	dobin ./acceltcp
}
