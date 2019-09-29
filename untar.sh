#!/bin/bash
##################################################
## Make sure that you installed the packages
## described here:
## ./installer/README.md
##################################################
## vars
JAVA_OUTPUT="j2sdk-image"
SCK="java11-sck"
FOLDER="OBF_DROP_DIR"

###################################################
## Do the hustle
##################################################
## delete the old folders...
if [ -d "$JAVA_OUTPUT" ]; then
    rm -rf $JAVA_OUTPUT
fi

if [ -d "$SCK" ]; then
    rm -rf $SCK
fi

## find the file name, we want the j2sdk. The output
## folder contains just one file matching that name, 
## so ill make this simple...
FILE=$(ls "$FOLDER" | grep jdk)

## some sanity
if [ -z "$FILE" ]; then
    echo "File <$FILE> was not found, exiting..."
    exit
fi

echo "Uncompressing <$FILE> to <$PWD>"
tar xvjf $FOLDER/$FILE

## now, just rename the folder
mv $JAVA_OUTPUT $SCK
## done

## testing
if [ -x $SCK/bin/java ]; then
  $SCK/bin/java -version
else
  echo "can't find java in this folder $SCK, build failed"
  exit -1
fi

## succeed
echo "Untar success!"
