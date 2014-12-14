export IOS_CONFIGURE_PREFIX=$HOME/ghc-ios/i386-sysroot
PLATFORM=`xcrun --show-sdk-platform-path --sdk iphonesimulator`
HOST=i386-apple-darwin11
SYSROOT=$PLATFORM/Developer/SDKs/iPhoneSimulator.sdk
IOS_SIM_FLAG="-mios-simulator-version-min=4.3"

export PATH=$IOS_CONFIGURE_PREFIX/bin:$PATH

#
# Must reset PKG_CONFIG_PATH for cross-compiler environment
#
export PKG_CONFIG_PATH=
export PKG_CONFIG_LIBDIR=$IOS_CONFIGURE_PREFIX/lib/pkgconfig

#
# In a cross compiling environment 'isysroot' (for CFLAGS) and syslibroot (for LDFLAGS) are
# vital.
#


export CC="xcrun --sdk iphonesimulator --run gcc"
export CXX="xcrun --sdk iphonesimulator --run g++"
export LDFLAGS="-arch i386 -Wl,-syslibroot,$SYSROOT"
export CFLAGS="-arch i386 -I$IOS_CONFIGURE_PREFIX/include -L$IOS_CONFIGURE_PREFIX/lib -isysroot $SYSROOT -Wl,-syslibroot,$SYSROOT $IOS_SIM_FLAG"
export CXXFLAGS=$CFLAGS

export CONFIGURE_CMD="./configure --prefix=$IOS_CONFIGURE_PREFIX --host=$HOST"
