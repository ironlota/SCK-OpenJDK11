#!/usr/bin/env bash
##################################################
## Make sure that you installed the packages
## described here:
## ./installer/README.md
##################################################
## vars
SRC_FOLDER="sources"
CURRENT_FOLDER=`pwd`
USE_CCACHE=true
###################################################
## in here, we just cd, configure and build
cd "$SRC_FOLDER"

if [ "$USE_CCACHE" = "true" ]; then
    echo "Using ccache"
    EXTRA_FLAGS="--enable-ccache --with-ccache-dir=$CURRENT_FOLDER/.ccache"
fi

# bash configure \
#      --with-freetype-include=/usr/include/freetype2 \
#      --with-freetype-lib=/usr/lib/x86_64-linux-gnu \
#      --disable-warnings-as-errors $EXTRA_FLAGS

make CONF=linux-x86_64-normal-server-release CONF_CHECK=auto images
echo "Done, use java/javac located at build/linux-x86_64-normal-server-release/images/jdk/bin"
cd "$CURRENT_FOLDER"
##################################################
## done

echo "Fresh-baked JDK11 is ready!"
