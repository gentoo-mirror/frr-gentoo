# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit eutils flag-o-matic multilib readme.gentoo-r1 vcs-snapshot cmake

if [[ ${PV} != 9999 ]]; then
	SRC_URI="https://github.com/rtrlib/rtrlib/releases/download/${PV}/v${PV}.tar.gz"
	KEYWORDS="amd64 ~x86 ~arm64"
	S="${WORKDIR}/v${PV}"
else
	inherit git-r3
	SRC_URI=""
	EGIT_REPO_URI="https://github.com/rtrlib/rtrlib.git"
	KEYWORDS=""
fi

DESCRIPTION="An open-source C implementation of the RPKI/Router Protocol client"
HOMEPAGE="http://rtrlib.realmv6.org/"

LICENSE="MIT"
SLOT="0"

IUSE="ssh"

COMMON_DEPEND="
	ssh? ( >=net-libs/libssh-0.5.0 )"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"

src_configure() {
	CMAKE_BUILD_TYPE="Release"
	if ! use ssh; then
		CMAKE_BUILD_TYPE="NoSSH"
	fi
	cmake_src_configure
}

src_install() {
	default
	cmake_src_install
	prune_libtool_files
}
