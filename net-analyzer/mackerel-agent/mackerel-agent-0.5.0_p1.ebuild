# Copyright 2014 Shota Fukumori (sora_h) <her@sorah.jp>
# Distributed under the terms of the MIT License
# $Header: $

EAPI=5

DESCRIPTION="Agent for mackerel.io"
HOMEPAGE="https://mackerel.io/"
SRC_URI="https://mackerel.io/assets/files/agents/${P/_p/-}.tar.gz"

LICENSE="mackerel-terms"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"


src_install() {
  dobin mackerel-agent

  insinto /etc/mackerel-agent
  doins mackerel-agent.conf

  insinto /etc/logrotate.d
  newins "${FILESDIR}/mackerel-agent.logrotate" mackerel-agent

  newinitd "${FILESDIR}/mackerel-agent.init.d" mackerel-agent
  newconfd "${FILESDIR}/mackerel-agent.conf.d" mackerel-agent

  keepdir /var/lib/mackerel-agent
}
