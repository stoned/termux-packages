TERMUX_PKG_HOMEPAGE=https://www.stunnel.org/
TERMUX_PKG_DESCRIPTION="Socket wrapper which can provide TLS support to ordinary applications"
TERMUX_PKG_VERSION=5.40
TERMUX_PKG_SRCURL=https://www.stunnel.org/downloads/stunnel-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=23acdb390326ffd507d90f8984ecc90e0d9993f6bd6eac1d0a642456565c45ff
TERMUX_PKG_DEPENDS="openssl, libutil"
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-shared --with-ssl=$TERMUX_PREFIX --disable-fips"
TERMUX_PKG_RM_AFTER_INSTALL="bin/stunnel3 share/man/man8/stunnel.*.8"

termux_step_pre_configure() {
	LDFLAGS+=" -llog"
}
