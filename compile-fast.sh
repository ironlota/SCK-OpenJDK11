#!/bin/bash
##################################################
## Make sure that you installed the packages
## described here:
## https://github.com/hgomez/obuildfactory/wiki/How-to-build-and-package-OpenJDK-11-on-Linux
##################################################
## vars
SRC_FOLDER="sources"
CURRENT_FOLDER="$PWD"
###################################################
## in here, we just cd, configure and build
cd "$SRC_FOLDER"
bash configure --with-freetype-include=/usr/include/freetype2 --with-freetype-lib=/usr/lib/x86_64-linux-gnu
make CONF=linux-x86_64-normal-server-release all
echo "Done, use java/javac located at build/linux-x86_64-normal-server-release/jdk/bin"
cd "$CURRENT_FOLDER"
##################################################
## done

echo "Fresh-baked JDK11 is ready!"
spd-say -i 100 "Hey Ray wake up!"
sleep 1
spd-say -i 100 "Fresh baked JDK is ready!"
