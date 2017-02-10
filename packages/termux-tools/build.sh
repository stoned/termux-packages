TERMUX_PKG_HOMEPAGE=https://termux.com/
TERMUX_PKG_DESCRIPTION="Basic system tools for Termux"
TERMUX_PKG_VERSION=0.36
TERMUX_PKG_PLATFORM_INDEPENDENT=yes
TERMUX_PKG_CONFFILES="etc/motd"

termux_step_make_install () {
	# Remove LD_LIBRARY_PATH from environment to avoid conflicting
	# with system libraries that system binaries may link against:
	for tool in am df getprop logcat ping ping6 ip pm settings; do
		WRAPPER_FILE=$TERMUX_PREFIX/bin/$tool
		echo '#!/bin/sh' > $WRAPPER_FILE
		echo 'unset LD_LIBRARY_PATH' >> $WRAPPER_FILE
		# Some tools require having /system/bin/app_process in the PATH,
		# at least am&pm on a Nexus 6p running Android 6.0:
		echo -n 'PATH=$PATH:/system/bin ' >> $WRAPPER_FILE
		echo "exec /system/bin/$tool \"\$@\"" >> $WRAPPER_FILE
		chmod +x $TERMUX_PREFIX/bin/$tool
	done

	cp -p $TERMUX_PKG_BUILDER_DIR/{dalvikvm,su,termux-fix-shebang,termux-reload-settings,termux-setup-storage,chsh,termux-open-url,termux-wake-lock,termux-wake-unlock} $TERMUX_PREFIX/bin/
	perl -p -i -e "s%\@TERMUX_PREFIX\@%${TERMUX_PREFIX}%g" $TERMUX_PREFIX/bin/dalvikvm

	cp $TERMUX_PKG_BUILDER_DIR/motd $TERMUX_PREFIX/etc/motd
}
