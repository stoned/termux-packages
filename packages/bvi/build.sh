TERMUX_PKG_HOMEPAGE=http://bvi.sourceforge.net/
TERMUX_PKG_DESCRIPTION="Binary file editor based on vi"
TERMUX_PKG_DEPENDS="ncurses"
TERMUX_PKG_VERSION=1.4.0
TERMUX_PKG_SRCURL=http://sourceforge.net/projects/bvi/files/bvi/${TERMUX_PKG_VERSION}/bvi-${TERMUX_PKG_VERSION}.src.tar.gz
TERMUX_PKG_SHA256=015a3c2832c7c097d98a5527deef882119546287ba8f2a70c736227d764ef802
TERMUX_PKG_FOLDERNAME=bvi-${TERMUX_PKG_VERSION}
TERMUX_PKG_BUILD_IN_SRC="yes"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="ac_cv_lib_ncursesw6_addnwstr=yes"
TERMUX_PKG_RM_AFTER_INSTALL="share/applications share/pixmaps"
