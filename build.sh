#!/bin/bash
##################################################
## Make sure that you installed the packages
## described here:
## https://github.com/hgomez/obuildfactory/wiki/How-to-build-and-package-OpenJDK-9-on-Linux
##################################################
## vars
export XCLEAN=true
export XBUILD=true
export XUSE_UPDATE=60
###################################################
## first, lets clean the output dir. DO NOT STORE
## ANYTHING IN THIS FOLDER, IT WILL GET DELETED!
if [ -d "OBF_DROP_DIR" ]; then
    rm -rf OBF_DROP_DIR
    echo "Deleted OBF_DROP_DIR"
fi
## build openjdk 11. The first parameter (if not empty)
## has to be one of the following:
## 1. --just-build when we are compiling...
## if empty, then it will build and clone when needed
echo "Building OpenJDK11"
$PWD/obuildfactory-sck/openjdk8/linux/standalone-job.sh --just-build

echo "Untar OpenJDK11"
$PWD/untar.sh
##################################################
## done
