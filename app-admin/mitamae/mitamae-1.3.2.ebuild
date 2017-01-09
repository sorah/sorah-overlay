# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit eutils

DESCRIPTION="Configuration management tool embedding mruby, which is alternative implementation of Itamae"
HOMEPAGE="https://github.com/k0kubun/mitamae"

mruby_commit=9cef2654025e6646b1d0ff259086fc9eb02fff84

SRC_URI="
  https://github.com/k0kubun/${PN}/archive/v${PV}.tar.gz
  https://github.com/k0kubun/mruby/archive/${mruby_commit}.tar.gz -> mruby-${mruby_commit}.tar.gz
"
LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="mitamae_plugins_secrets"


common_dep="
	mitamae_plugins_secrets? ( dev-libs/openssl )
	dev-libs/oniguruma
	virtual/pkgconfig
"
build_dep="dev-vcs/git dev-lang/ruby"

DEPEND="${build_dep} ${common_dep}"
RDEPEND="${common_dep}"

src_prepare() {
	MRUBY_WD="${WORKDIR}/mruby-${mruby_commit}" 
	cd "${MRUBY_WD}"
	# For --as-needed
	epatch "${FILESDIR}/mruby-pr-3381.patch"
	cd "$S"
	rmdir mruby
	mv "${MRUBY_WD}" ./mruby
	# Idea brought by https://aur.archlinux.org/cgit/aur.git/tree/PKGBUILD?h=mitamae
	cp "${FILESDIR}/build_config-${PV}.rb" ./build_config.rb
	default
}

src_compile() {
	cd "$S"
	if use mitamae_plugins_secrets; then
		export PORTAGE_ENABLE_MITAMAE_SECRETS=1
	fi
	./mruby/minirake compile
}

src_install() {
	dobin ./mruby/build/host/bin/mitamae
	if use mitamae_plugins_secrets; then
		dobin ./mruby/build/host/bin/mitamae-secrets
	fi
}
