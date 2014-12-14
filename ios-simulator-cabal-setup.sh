#!/bin/bash

if [ ! -f  Setup ]; then
  echo Could not find 'Setup'
  exit 1
fi

PREFIX=$HOME/ghc-ios/i386-sysroot

export PATH=$PREFIX/bin:$PATH

#
# Must reset PKG_CONFIG_PATH for cross-compiler environment
#
export PKG_CONFIG_PATH=
export PKG_CONFIG_LIBDIR=$PREFIX/lib/pkgconfig

export COMMON="--builddir=dist/i386-apple-darwin11"

export COMPILE="--with-ghc=i386-apple-darwin11-ghc
                --with-ghc-pkg=i386-apple-darwin11-ghc-pkg
                --with-gcc=i386-apple-darwin11-clang
                --with-ld=i386-apple-darwin11-ld
                --hsc2hs-options=--cross-compile"

export CONFIG="--configure-option=--host=i386-apple-darwin11
               --prefix=$PREFIX
               --package-db=user \
               --disable-library-profiling
               --disable-shared
               --extra-include-dirs=$PREFIX/include
               --extra-lib-dirs=$PREFIX/lib"

# Some extra options, depending on what command was invoked.
case $1 in
    configure)         OPTIONS="$COMMON $COMPILE $CONFIG" ;;
    install)           OPTIONS="$COMMON" ;;
    build)             OPTIONS="$COMMON $COMPILE" ;;
    list|info|update)  OPTIONS="" ;;
    "")                OPTIONS="" ;;
    *)                 OPTIONS="$COMMON" ;;
esac

./Setup $OPTIONS "$@"