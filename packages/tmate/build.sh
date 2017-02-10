TERMUX_PKG_HOMEPAGE=https://tmate.io
TERMUX_PKG_DESCRIPTION="Terminal multiplexer with instant terminal sharing"
TERMUX_PKG_VERSION=2.2.1
TERMUX_PKG_REVISION=1
TERMUX_PKG_SRCURL=https://github.com/tmate-io/tmate/archive/${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=d9c2ac59f42e65aac5f500f0548ea8056fd79c9c5285e5af324d833e2a84c305
TERMUX_PKG_FOLDERNAME=tmate-${TERMUX_PKG_VERSION}
TERMUX_PKG_DEPENDS="libandroid-support, libevent, libmsgpack, libssh, libutil, ncurses"

termux_step_pre_configure () {
	CFLAGS+=" -DIOV_MAX=1024"

	cd $TERMUX_PKG_SRCDIR
	./autogen.sh
}
