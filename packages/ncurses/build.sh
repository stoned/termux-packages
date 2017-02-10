TERMUX_PKG_HOMEPAGE=http://invisible-island.net/ncurses/
TERMUX_PKG_DESCRIPTION="Library for text-based user interfaces in a terminal-independent manner"
_MAJOR_VERSION=6.0
_MINOR_VERSION=20170114
TERMUX_PKG_VERSION=${_MAJOR_VERSION}.${_MINOR_VERSION}
TERMUX_PKG_SRCURL=ftp://invisible-island.net/ncurses/current/ncurses-${_MAJOR_VERSION}-${_MINOR_VERSION}.tgz
TERMUX_PKG_SHA256=6861b00bf85116efdb083ce5a8387268616c2c5500b5b17c692b13975049ac97
# --without-normal disables static libraries:
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--enable-overwrite --enable-const --without-cxx-binding --without-normal --without-static --with-shared --without-debug --enable-widec --enable-ext-colors --enable-ext-mouse --enable-pc-files --with-pkg-config-libdir=$PKG_CONFIG_LIBDIR --without-ada --without-tests --mandir=$TERMUX_PREFIX/share/man ac_cv_header_locale_h=no"
TERMUX_PKG_RM_AFTER_INSTALL="bin/ncursesw6-config share/man/man1/ncursesw6-config.1 bin/infotocap share/man/man1/infotocap.1m bin/captoinfo share/man/man1/captoinfo.1m"

termux_step_post_make_install () {
	cd $TERMUX_PREFIX/lib
	for lib in form menu ncurses panel; do
		for file in lib${lib}w.so*; do 
			ln -s -f $file `echo $file | sed 's/w//'`
		done
		(cd pkgconfig && ln -s -f ${lib}w.pc `echo $lib | sed 's/w//'`.pc)
	done

	# Some packages wants this:
	cd $TERMUX_PREFIX/include/
	rm -Rf ncursesw
	mkdir ncursesw
	cd ncursesw
	ln -s ../{ncurses.h,termcap.h,panel.h,unctrl.h,menu.h,form.h,tic.h,nc_tparm.h,term.h,eti.h,term_entry.h,ncurses_dll.h,curses.h} .
}

termux_step_post_massage () {
	cd $TERMUX_PKG_MASSAGEDIR
	# Strip away 30 years of cruft to decrease size.
	local TI=./$TERMUX_PREFIX/share/terminfo
	mv $TI $TERMUX_PKG_TMPDIR/full-terminfo
	mkdir -p $TI/{a,d,e,n,l,p,r,s,t,v,x}
	cp $TERMUX_PKG_TMPDIR/full-terminfo/a/ansi $TI/a/
	cp $TERMUX_PKG_TMPDIR/full-terminfo/d/{dtterm,dumb} $TI/d/
	cp $TERMUX_PKG_TMPDIR/full-terminfo/e/eterm-color $TI/e/
	cp $TERMUX_PKG_TMPDIR/full-terminfo/n/nsterm $TI/n/
	cp $TERMUX_PKG_TMPDIR/full-terminfo/l/linux $TI/l/
	cp $TERMUX_PKG_TMPDIR/full-terminfo/p/putty{,-256color} $TI/p/
	cp $TERMUX_PKG_TMPDIR/full-terminfo/r/rxvt{,-256color} $TI/r/
	cp $TERMUX_PKG_TMPDIR/full-terminfo/s/screen{,2,-256color} $TI/s/
	cp $TERMUX_PKG_TMPDIR/full-terminfo/t/tmux{,-256color} $TI/t/
	cp $TERMUX_PKG_TMPDIR/full-terminfo/v/{vt52,vt100,vt102} $TI/v/
	cp $TERMUX_PKG_TMPDIR/full-terminfo/x/xterm{,-color,-new,-16color,-256color,+256color} $TI/x/
}
