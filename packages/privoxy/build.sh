TERMUX_PKG_HOMEPAGE=https://www.privoxy.org
TERMUX_PKG_DESCRIPTION="Privoxy is a non-caching web proxy with advanced filtering capabilities"
TERMUX_PKG_VERSION=3.0.26
TERMUX_PKG_SRCURL=https://www.privoxy.org/sf-download-mirror/Sources/$TERMUX_PKG_VERSION%20%28stable%29/privoxy-$TERMUX_PKG_VERSION-stable-src.tar.gz
TERMUX_PKG_FOLDERNAME=privoxy-$TERMUX_PKG_VERSION-stable
TERMUX_PKG_SHA256=57e415b43ee5dfdca74685cc034053eaae962952fdabd086171551a86abf9cd8
TERMUX_PKG_CONFFILES='etc/privoxy/config etc/privoxy/match-all.action etc/privoxy/trust etc/privoxy/user.action etc/privoxy/user.filter etc/privoxy/default.action etc/privoxy/default.filter'
TERMUX_PKG_BUILD_REVISION=1
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-dynamic-pcre --sysconfdir=$TERMUX_PREFIX/etc/privoxy"
TERMUX_PKG_BUILD_IN_SRC=yes

termux_step_pre_configure() {
    autoheader
    autoconf

    # avoid 'aarch64-linux-android-strip': No such file or directory
    ln -s "$TERMUX_STANDALONE_TOOLCHAIN/bin/$STRIP" .
}

termux_step_post_make_install() {
    # delete link created to avoid errors
    rm -f "$TERMUX_PREFIX/sbin/$STRIP"
}

termux_step_post_massage() {
    # copy default config files
    for f in $TERMUX_PKG_CONFFILES; do
        cp "$TERMUX_PKG_SRCDIR/$(basename $f)" "$TERMUX_PKG_MASSAGEDIR/$TERMUX_PREFIX/$f"
    done
}
