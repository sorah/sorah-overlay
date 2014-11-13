EAPI=5

inherit autotools eutils git-2

DESCRIPTION="bitplane/temper, App to log the current temperature from a Temper1 sensor"
HOMEPAGE="https://github.com/bitplane/temper"
EGIT_REPO_URI="https://github.com/bitplane/temper"

LICENSE=""
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86"
IUSE="udev"

DEPEND="
	udev? ( sys-fs/udev )
	dev-libs/libusb"
RDEPEND="${DEPEND}"

src_install() {
	dobin temper
	if use udev ; then
		insinto /etc/udev/rules.d
		doins 60-temper.rules
	fi
}
