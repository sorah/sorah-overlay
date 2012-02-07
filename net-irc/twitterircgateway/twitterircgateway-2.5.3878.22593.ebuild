# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit eutils

DESCRIPTION="View & Send tweets from your IRC client"
HOMEPAGE="http://www.misuzilla.org/dist/net/twitterircgateway/"
SRC_URI="http://www.misuzilla.org/dist/net/twitterircgateway/archives/TwitterIrcGateway-2.5.3878.22593.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-lang/mono"
RDEPEND="${DEPEND}"

pkg_setup() {
	enewuser tig
}

src_install() {
	local dest="${D}/opt/twitterircgateway"

	mkdir -p ${dest}
	cp -R "${WORKDIR}/TwitterIrcGateway"/* "${dest}/" || die
	fowners tig "${dest}/TwitterIrcGateway.exe.config"

	doinitd "${FILESDIR}/tig"
}
