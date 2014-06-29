# Copyright 2014 sorah
# Distributed under the terms of the MIT License
# $Header: $

EAPI=5
inherit git-2

DESCRIPTION="Dump caption from TS file into ass file"
HOMEPAGE="https://github.com/eagletmt/eagletmt-recutils/tree/master/assdumper"
EGIT_REPO_URI="https://github.com/eagletmt/eagletmt-recutils"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="dev-lang/go"
RDEPEND=""

pkg_setup() {
	export GOPATH=$WORKDIR
}

src_prepare() {
	mkdir $WORKDIR/src
	mkdir $WORKDIR/bin
	cd $WORKDIR/$P/assdumper
	go get -d
}

src_compile() {
	cd $WORKDIR/$P/assdumper
	go build assdumper.go
}

src_install() {
   cd $WORKDIR/$P/assdumper
   dobin assdumper
}
