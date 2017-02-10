TERMUX_PKG_HOMEPAGE=https://www.perl.org/
TERMUX_PKG_DESCRIPTION="Capable, feature-rich programming language"
# cpan modules will require make:
TERMUX_PKG_VERSION=5.24.1
TERMUX_PKG_SRCURL=http://www.cpan.org/src/5.0/perl-${TERMUX_PKG_VERSION}.tar.gz
TERMUX_PKG_SHA256=e6c185c9b09bdb3f1b13f678999050c639859a7ef39c8cad418448075f5918af
# Does not work with parallell builds:
TERMUX_MAKE_PROCESSES=1
TERMUX_PKG_RM_AFTER_INSTALL="bin/perl${TERMUX_PKG_VERSION}"
TERMUX_PKG_BUILD_IN_SRC="yes"
TERMUX_PKG_NO_DEVELSPLIT=yes

termux_step_post_extract_package () {
	# This port uses perl-cross: http://arsv.github.io/perl-cross/
	local PERLCROSS_VERSION=1.1.3
	local PERLCROSS_FILE=perl-cross-${PERLCROSS_VERSION}.tar.gz
	local PERLCROSS_TAR=$TERMUX_PKG_CACHEDIR/$PERLCROSS_FILE
	if [ ! -f $PERLCROSS_TAR ]; then
		termux_download https://github.com/arsv/perl-cross/releases/download/$PERLCROSS_VERSION/$PERLCROSS_FILE \
		                $PERLCROSS_TAR \
		                181b24ff71815fb2c8065e6ea139d106796eee0964aebfd8081f0b7f69e0696d
	fi
	tar xf $PERLCROSS_TAR
	cd perl-cross-${PERLCROSS_VERSION}
	cp -Rf * ../

	# Remove old installation to force fresh:
	rm -rf $TERMUX_PREFIX/lib/perl5

	# Export variable used by Kid.pm.patch:
	export TERMUX_PKG_SRCDIR
}

termux_step_configure () {
	export PATH=$PATH:$TERMUX_STANDALONE_TOOLCHAIN/bin

	ORIG_AR=$AR; unset AR
	ORIG_AS=$AS; unset AS
	ORIG_CC=$CC; unset CC
	ORIG_CXX=$CXX; unset CXX
	ORIG_CPP=$CPP; unset CPP
	ORIG_CFLAGS=$CFLAGS; unset CFLAGS
	ORIG_CPPFLAGS=$CPPFLAGS; unset CPPFLAGS
	ORIG_CXXFLAGS=$CXXFLAGS; unset CXXFLAGS
	ORIG_LDFLAGS=$LDFLAGS; unset LDFLAGS
	ORIG_RANLIB=$RANLIB; unset RANLIB
	ORIG_LD=$LD; unset LD

	# Since we specify $TERMUX_PREFIX/bin/sh below for the shell
	# it will be run during the build, so temporarily (removed in
	# termux_step_post_make_install below) setup symlink:
	rm -f $TERMUX_PREFIX/bin/sh
	ln -s /bin/sh $TERMUX_PREFIX/bin/sh

	cd $TERMUX_PKG_BUILDDIR
	$TERMUX_PKG_SRCDIR/configure \
		--target=$TERMUX_HOST_PLATFORM \
		-Dsysroot=$TERMUX_STANDALONE_TOOLCHAIN/sysroot \
		-Dprefix=$TERMUX_PREFIX \
		-Dsh=$TERMUX_PREFIX/bin/sh \
		-Dcc=$ORIG_CC \
		-Duseshrplib
}

termux_step_post_make_install () {
	# Replace hardlinks with symlinks:
	cd $TERMUX_PREFIX/share/man/man1
	rm {perlbug.1,c2ph.1}
	ln -s perlthanks.1 perlbug.1
	ln -s pstruct.1 c2ph.1

	# Cleanup:
	rm $TERMUX_PREFIX/bin/sh

	cd $TERMUX_PREFIX/lib
	ln -f -s perl5/${TERMUX_PKG_VERSION}/${TERMUX_ARCH}-android/CORE/libperl.so libperl.so

	cd $TERMUX_PREFIX/include
	ln -f -s ../lib/perl5/${TERMUX_PKG_VERSION}/${TERMUX_ARCH}-android/CORE perl
}
