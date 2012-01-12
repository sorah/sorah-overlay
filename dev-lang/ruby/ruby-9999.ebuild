# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/ruby/ruby-1.9.2-r1.ebuild,v 1.2 2011/07/15 17:25:03 mattst88 Exp $

EAPI=2

#PATCHSET=

inherit autotools eutils flag-o-matic multilib versionator subversion

RUBYPL=0

MY_P="${PN}-2.0.0dev"
S=${WORKDIR}/${MY_P}

SLOT=2.0
MY_SUFFIX=$(delete_version_separator 1 ${SLOT})
# 2.0 still uses 1.9.1
RUBYVERSION=1.9.1

DESCRIPTION="An object-oriented scripting language"
HOMEPAGE="http://www.ruby-lang.org/"
SRC_URI="http://dev.gentoo.org/~flameeyes/ruby-team/ruby-patches-1.9.3_rc1.tar.bz2"
ESVN_REPO_URI="http://svn.ruby-lang.org/repos/ruby/trunk"

LICENSE="|| ( Ruby BSD-2 )"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE="berkdb debug doc examples gdbm ipv6 +rdoc rubytests socks5 ssl tk xemacs ncurses +readline yaml" #libedit

# libedit support is removed everywhere because of this upstream bug:
# http://redmine.ruby-lang.org/issues/show/3698

RDEPEND="
	berkdb? ( sys-libs/db )
	gdbm? ( sys-libs/gdbm )
	ssl? ( dev-libs/openssl )
	socks5? ( >=net-proxy/dante-1.1.13 )
	tk? ( dev-lang/tk[threads] )
	ncurses? ( sys-libs/ncurses )
	readline?  ( sys-libs/readline )
	yaml? ( dev-libs/libyaml )
	virtual/libffi
	sys-libs/zlib
	>=app-admin/eselect-ruby-20100402
	!=dev-lang/ruby-cvs-${SLOT}*
	!<dev-ruby/rdoc-2
	!dev-ruby/rubygems
	!dev-ruby/rexml
	!dev-ruby/rake"
#	libedit? ( dev-libs/libedit )
#	!libedit? ( readline? ( sys-libs/readline ) )

DEPEND="${RDEPEND}"
PDEPEND="
	rdoc? ( >=dev-ruby/rdoc-2.5.11[ruby_targets_ruby19] )
	xemacs? ( app-xemacs/ruby-modes )
	!dev-ruby/rubygems
	!dev-ruby/rake"

src_unpack() {
	default
	subversion_src_unpack
}

src_prepare() {
	#EPATCH_FORCE="yes" EPATCH_SUFFIX="patch" \
	#EPATCH_EXCLUDE="007_berkdb-5.0.patch 009_berkdb-5.0.patch" \
	#     epatch "${WORKDIR}/patches"
	#epatch "${FILESDIR}/ruby-1.9.3_rc1"

	#einfo "Unbundling gems..."
	#cd $S
	#rm -r \
	#	bin/gem \
	#	|| die "removal failed"

	# Fix a hardcoded lib path in configure script
	sed -i -e "s:\(RUBY_LIB_PREFIX=\"\${prefix}/\)lib:\1$(get_libdir):" \
		configure.in || die "sed failed"

	eautoreconf
}

src_configure() {
	local myconf=

	# -fomit-frame-pointer makes ruby segfault, see bug #150413.
	filter-flags -fomit-frame-pointer
	# In many places aliasing rules are broken; play it safe
	# as it's risky with newer compilers to leave it as it is.
	append-flags -fno-strict-aliasing
	# SuperH needs this
	use sh && append-flags -mieee

	# Socks support via dante
	if use socks5 ; then
		# Socks support can't be disabled as long as SOCKS_SERVER is
		# set and socks library is present, so need to unset
		# SOCKS_SERVER in that case.
		unset SOCKS_SERVER
	fi

	# Increase GC_MALLOC_LIMIT if set (default is 8000000)
	if [ -n "${RUBY_GC_MALLOC_LIMIT}" ] ; then
		append-flags "-DGC_MALLOC_LIMIT=${RUBY_GC_MALLOC_LIMIT}"
	fi

	# ipv6 hack, bug 168939. Needs --enable-ipv6.
	use ipv6 || myconf="${myconf} --with-lookup-order-hack=INET"

#	if use libedit; then
#		einfo "Using libedit to provide readline extension"
#		myconf="${myconf} --enable-libedit --with-readline"
#	elif use readline; then
#		einfo "Using readline to provide readline extension"
#		myconf="${myconf} --with-readline"
#	else
#		myconf="${myconf} --without-readline"
#	fi
	myconf="${myconf} $(use_with readline)"

	econf \
		--program-suffix=${MY_SUFFIX} \
		--with-soname=ruby${MY_SUFFIX} \
		--enable-shared \
		--enable-pthread \
		--with-baseruby="ruby --disable-gems" \
		$(use_enable socks5 socks) \
		$(use_enable doc install-doc) \
		--enable-ipv6 \
		$(use_enable debug) \
		$(use_with berkdb dbm) \
		$(use_with gdbm) \
		$(use_with ssl openssl) \
		$(use_with tk) \
		$(use_with ncurses curses) \
		$(use_with yaml psych) \
		${myconf} \
		--enable-option-checking=no \
		|| die "econf failed"
}

src_compile() {
	emake EXTLDFLAGS="${LDFLAGS}" || die "emake failed"
}

src_test() {
	emake -j1 test || die "make test failed"

	elog "Ruby's make test has been run. Ruby also ships with a make check"
	elog "that cannot be run until after ruby has been installed."
	elog
	if use rubytests; then
		elog "You have enabled rubytests, so they will be installed to"
		elog "/usr/share/${PN}-${SLOT}/test. To run them you must be a user other"
		elog "than root, and you must place them into a writeable directory."
		elog "Then call: "
		elog
		elog "ruby${MY_SUFFIX} -C /location/of/tests runner.rb"
	else
		elog "Enable the rubytests USE flag to install the make check tests"
	fi
}

src_install() {
	# Ruby is involved in the install process, we don't want interference here.
	unset RUBYOPT

	local MINIRUBY=$(echo -e 'include Makefile\ngetminiruby:\n\t@echo $(MINIRUBY)'|make -f - getminiruby)
	local RBPLATFORM=$($MINIRUBY -e 'print RUBY_PLATFORM')

	LD_LIBRARY_PATH="${D}/usr/$(get_libdir)${LD_LIBRARY_PATH+:}${LD_LIBRARY_PATH}"
	RUBYLIB="${S}:${D}/usr/$(get_libdir)/ruby/${RUBYVERSION}"
	for d in $(find "${S}/ext" -type d) ; do
		RUBYLIB="${RUBYLIB}:$d"
	done
	export LD_LIBRARY_PATH RUBYLIB

	make DESTDIR=${D} install-nodoc || die "make install-nodoc failed"

	if use doc; then
		make DESTDIR=${D} install-doc || die "make install-doc failed"
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r sample
	fi

	dosym "libruby${MY_SUFFIX}$(get_libname ${PV%_*})" \
		"/usr/$(get_libdir)/libruby$(get_libname ${PV%.*})"
	dosym "libruby${MY_SUFFIX}$(get_libname ${PV%_*})" \
		"/usr/$(get_libdir)/libruby$(get_libname ${PV%_*})"

	dodoc ChangeLog NEWS doc/* README* || die

	if use rubytests; then
		pushd test
		insinto /usr/share/${PN}-${SLOT}/test
		doins -r .
		popd
	fi
}

pkg_postinst() {
	if [[ ! -n $(readlink "${ROOT}"usr/bin/ruby) ]] ; then
		eselect ruby set ruby${MY_SUFFIX}
	fi

	elog
	elog "To switch between available Ruby profiles, execute as root:"
	elog "\teselect ruby set ruby(18|19|...)"
	elog
}

pkg_postrm() {
	eselect ruby cleanup
}
