#!/bin/bash

#
# This script should be used when i386-apple-darwin11-cabal cannot be used
# because the cabal file is not using Distribution.Simple.
#
# In this case manually build Setup.hs (to executable "Setup") for the host machine,
# then run this script.
#
#   $ ghc --make Setup.hs
#   $ setup-ios-i386-wrapper.sh
#
if [ "$IOS_I386_BUILD_SYSROOT" = ""  ]; then
  echo "Environment variable IOS_I386_BUILD_SYSROOT is not set"
  exit 1
fi

if [ ! -f  Setup ]; then
  if [ -f Setup.hs -o -f Setup.lhs ]; then
    ghc --make Setup.?hs
  fi
  if [ ! -f  Setup ]; then
    echo Could not find 'Setup or Setup.(l)hs'
    exit 1
  fi
fi

if [ $# -lt 1 ]; then
  echo "Usage: $(basename $0) clean|configure|build|install"
  exit 1
fi

ARG=$1
shift

ARCH=i386-apple-darwin11
BUILDDIR=dist/$ARCH

case $ARG in
  clean)
    ./Setup clean
  ;;
  configure)
    ./Setup configure  \
      --ghc \
      --builddir=$BUILDDIR \
      --with-compiler=$ARCH-ghc \
      --with-gcc=$ARCH-clang \
      --with-ld=$ARCH-ld \
      --with-ghc-pkg=$ARCH-ghc-pkg \
      --with-hc-pkg=$ARCH-ghc-pkg \
      --hsc2hs-options=--cross-compile \
      --prefix=$IOS_I386_BUILD_SYSROOT \
      --package-db=user \
      "$@"
  ;;

  build)
    ./Setup build --builddir=$BUILDDIR "$@"
  ;;

  install)
    ./Setup install --builddir=$BUILDDIR "$@"
  ;;
  *)
    echo "Unknown command. Use configure|build|install"
  ;;
esac

