#!/bin/bash
##################################################
## Make sure that you installed the packages
## described here:
## ./installer/README.md
##################################################
## vars
SRC_FOLDER="sources"
CURRENT_FOLDER="$PWD"
###################################################
## in here, we just cd, configure and build
cd "$SRC_FOLDER"
bash configure \
     --with-freetype-include=/usr/include/freetype2 \
     --with-freetype-lib=/usr/lib/x86_64-linux-gnu
make CONF=linux-x86_64-normal-server-release all
echo "Done, use java/javac located at build/linux-x86_64-normal-server-release/jdk/bin"
cd "$CURRENT_FOLDER"
##################################################
## done

echo "Fresh-baked JDK11 is ready!"
