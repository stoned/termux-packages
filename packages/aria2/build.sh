TERMUX_PKG_HOMEPAGE=https://aria2.github.io
TERMUX_PKG_DESCRIPTION="Multi-protocol & multi-source command-line download utility supporting HTTP/HTTPS, FTP, BitTorrent and Metalink"
TERMUX_PKG_VERSION=1.31.0
TERMUX_PKG_SRCURL=https://github.com/aria2/aria2/releases/download/release-${TERMUX_PKG_VERSION}/aria2-${TERMUX_PKG_VERSION}.tar.xz
TERMUX_PKG_SHA256=7b85619048b23406f241e38a5b1b8b0bc2cae9e80fd117810c2a71ecca813f8c
TERMUX_PKG_DEPENDS="c-ares, openssl, libxml2"
# sqlite3 is only used for loading cookies from firefox or chrome:
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--with-openssl --without-gnutls --without-libuv --without-sqlite3 ac_cv_search_getaddrinfo=no ac_cv_func_getaddrinfo=yes ac_cv_func_gettimeofday=yes ac_cv_func_sleep=yes ac_cv_func_usleep=yes ac_cv_func_basename=yes"
