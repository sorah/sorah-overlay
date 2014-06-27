# Copyright 2014 Shota Fukumori (sora_h)
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="DNS server helps resolving your EC2 instances' IP addresses"
HOMEPAGE="https://github.com/sorah/ec2nm"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz"

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
	mkdir -p $WORKDIR/src/github.com/sorah
	mkdir $WORKDIR/bin
	ln -s $WORKDIR/$P $WORKDIR/src/github.com/sorah/ec2nm
	cd $WORKDIR/src/github.com/sorah/ec2nm
	go get -d
}

src_compile() {
	go install github.com/sorah/ec2nm
}

src_install() {
   cd $WORKDIR
   dobin bin/ec2nm
}
