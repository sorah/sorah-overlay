# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit eutils git-r3

DESCRIPTION="Configuration management tool embedding mruby, which is alternative implementation of Itamae"
HOMEPAGE="https://github.com/k0kubun/mitamae"
EGIT_REPO_URI="https://github.com/k0kubun/mitamae"
EGIT_SUBMODULES=( mruby )

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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
	cd "$S/mruby"
	epatch "${FILESDIR}/mruby-pr-3381.patch"
	cd "$S"
	cp "${FILESDIR}/gems-9999.rb" .
	sed -i.bak -e 's/^def gem_config(conf)$/&; binding.eval File.read(File.expand_path(File.join(__FILE__, "..", "gems-9999.rb"))), "gems-9999.rb", 1;/' build_config.rb
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
