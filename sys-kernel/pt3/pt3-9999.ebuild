# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ruby/ruby-1.9.2-r1.ebuild,v 1.2 2011/07/15 17:25:03 mattst88 Exp $

EAPI=4

inherit autotools eutils git-2 linux-mod

DESCRIPTION="(^o^)/"
HOMEPAGE="https://github.com/m-tsudo/pt3"
EGIT_REPO_URI="https://github.com/m-tsudo/pt3"

LICENSE="GPL-3"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE=""

RDEPEND="sys-fs/udev"
DEPEND="${RDEPEND} virtual/pkgconfig"

MODULE_NAMES="pt3_drv(kernel:drivers/video:${S}:${S})"
BUILD_TARGETS="all"

src_install() {
	local udevdir="$(pkg-config --variable=udevdir udev)"
	insinto "${udevdir}"/rules.d
	doins etc/99-pt3.rules
	linux-mod_src_install
}
