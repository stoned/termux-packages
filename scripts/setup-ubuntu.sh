#!/bin/bash
set -e -u

PACKAGES=""
PACKAGES+=" ant" # Used by jack and aptsigner.
PACKAGES+=" asciidoc"
PACKAGES+=" automake"
PACKAGES+=" bison"
PACKAGES+=" clang" # Used by golang, useful to have same compiler building.
PACKAGES+=" curl" # Used for fetching sources.
PACKAGES+=" flex"
PACKAGES+=" gettext" # Provides 'msgfmt' which the apt build uses.
PACKAGES+=" git" # Used by the neovim build.
PACKAGES+=" help2man"
PACKAGES+=" intltool" # Used by qalc build.
PACKAGES+=" libgdk-pixbuf2.0-dev" # Provides 'gkd-pixbuf-query-loaders' which the librsvg build uses.
PACKAGES+=" libglib2.0-dev" # Provides 'glib-genmarshal' which the glib build uses.
PACKAGES+=" libtool-bin"
PACKAGES+=" lzip"
PACKAGES+=" python3.6"
PACKAGES+=" subversion" # Used by the netpbm build.
PACKAGES+=" tar"
PACKAGES+=" unzip"
PACKAGES+=" m4"
PACKAGES+=" openjdk-8-jdk" # Used for android-sdk.
PACKAGES+=" pkg-config"
PACKAGES+=" python-docutils" # For rst2man, used by mpv.
PACKAGES+=" scons"
PACKAGES+=" texinfo"
PACKAGES+=" xmlto"
PACKAGES+=" xutils-dev" # Provides 'makedepend' which the openssl build uses.

DEBIAN_FRONTEND=noninteractive sudo apt-get install -yq $PACKAGES

sudo mkdir -p /data/data/com.termux/files/usr
sudo chown -R `whoami` /data
