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
  echo Could not find 'Setup'
  exit 1
fi

./Setup configure \
  --ghc \
  --with-ghc=i386-apple-darwin11-ghc \
  --with-ghc-pkg=i386-apple-darwin11-ghc-pkg \
  --with-gcc=i386-apple-darwin11-clang \
  --with-ld=i386-apple-darwin11-ld \
  --with-hc-pkg=i386-apple-darwin11-ghc-pkg \
  --hsc2hs-options=--cross-compile \
  --prefix=$IOS_I386_BUILD_SYSROOT \
  --package-db=user \
  "$@"
