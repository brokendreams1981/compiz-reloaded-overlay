# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

PYTHON_COMPAT=( python2_7 )
DISTUTILS_IN_SOURCE_BUILD=1
inherit distutils-r1 git-r3 gnome2-utils

DESCRIPTION="Compiz settings manager focused on simplicity for an end-user"
HOMEPAGE="https://github.com/compiz-reloaded"
EGIT_REPO_URI="git://github.com/compiz-reloaded/simple-ccsm.git"

LICENSE="GPL-2+"
SLOT="0"
IUSE="gtk3"

DEPEND="
	dev-util/intltool
	virtual/pkgconfig
"

RDEPEND="
	>=dev-python/compizconfig-python-${PV}[${PYTHON_USEDEP}]
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	>=x11-misc/ccsm-${PV}[gtk3=,${PYTHON_USEDEP}]
"

python_prepare_all() {
	# return error if wrong arguments passed to setup.py
	sed -i -e 's/raise SystemExit/\0(1)/' setup.py || die 'sed on setup.py failed'
	distutils-r1_python_prepare_all
}

python_configure_all() {
	mydistutilsargs=(
		build \
		--prefix=/usr \
		--with-gtk=$(usex gtk3 3.0 2.0)
	)
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
