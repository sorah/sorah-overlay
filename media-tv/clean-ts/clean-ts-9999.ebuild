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

DEPEND="dev-util/cmake >=media-video/ffmpeg-1.1.0"
RDEPEND=">=media-video/ffmpeg-1.1.0"

src_configure() {
	cd $S/clean-ts
	cmake . -DCMAKE_BUILD_TYPE=release
}

src_compile() {
	cd $S/clean-ts
	make
}

src_install() {
	cd $S/clean-ts
	dobin ./clean-ts
}
