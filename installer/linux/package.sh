#!/bin/bash
#

# Required vars :
#
# OBF_BUILD_PATH (absolute path of project, ie obuildfactory/openjdk11/linux)
# OBF_PROJECT_NAME (ie: openjdk11)
# OBF_BUILD_NUMBER (ie: b50)
#
# Optional vars :
#
# OBF_JDK_MODEL (ie: x86_64 to override default calculated)

PACKAGE_NAME="jdk-11.0.5-openjdk"
PACKAGE_DESCRIPTION="OpenJDK 11 Native Package"

pushd $OBF_BUILD_PATH/rpm >>/dev/null

CPU_BUILD_ARCH=`uname -m`

if [ -z "$OBF_JDK_MODEL" ]; then
    OBF_JDK_MODEL=$CPU_BUILD_ARCH
fi

if [ "$XDEBUG" = "true" ]; then

    FILENAME_PREFIX="-fastdebug"
    DESCRIPTION_ADDON=" (with FastDebug support inside)"

fi

if [ "$XUSE_FPM" = "true" ]; then

    if [ -z "$XPACKAGE_MODE" ]; then
        if [ -x /usr/bin/apt-get ]; then
            XPACKAGE_MODE=deb
        else
            XPACKAGE_MODE=rpm
        fi
    fi

    if [ "$XDEBUG" = "true" ]; then
        FILENAME_PREFIX="-fastdebug"
    fi

    CPU_BUILD_ARCH=`uname -m`

    if [ -z "$OBF_JDK_MODEL" ]; then
     OBF_JDK_MODEL=$CPU_BUILD_ARCH
    fi

    mkdir -p tmp/$OBF_PROJECT_NAME
    pushd tmp/$OBF_PROJECT_NAME
    tar xvjf $OBF_DROP_DIR/jdk$FILENAME_PREFIX-$OBF_BASE_ARCH-$OBF_BUILD_NUMBER-$OBF_BUILD_DATE.tar.bz2
    XDEST_DIR=opt/obuildfactory/$PACKAGE_NAME-$OBF_JDK_MODEL$FILENAME_PREFIX
    rm -rf $XDEST_DIR
    mkdir -p $XDEST_DIR
    mv jdk/* $XDEST_DIR

    rm -rf *.$XPACKAGE_MODE
    fpm --verbose -s dir -t $XPACKAGE_MODE -n $OBF_PROJECT_NAME$FILENAME_PREFIX -v "11.0-$OBF_BUILD_NUMBER" --rpm-auto-add-directories \
    --category language -m "Ray Andrew <raydreww@gmail.com>" \
    --url https://github.com/rayandrews/SCK-OpenJDK11/ \
    --license "GPL-2.0" \
    --description "$PACKAGE_DESCRIPTION$DESCRIPTION_ADDON" \
    -C . opt

    mv *.$XPACKAGE_MODE $OBF_DROP_DIR

    popd

else

    [ "$XPACKAGE_MODE" = "generic" ] && PKG_DIR="GENERIC" || PKG_DIR="RPMS"

    rm -rf TEMP
    mkdir -p TEMP
    rm -rf BUILD
    mkdir -p BUILD
    rm -rf $PKG_DIR
    mkdir -p $PKG_DIR
    mkdir -p SOURCES

    if [ -f $OBF_DROP_DIR/jdk$FILENAME_PREFIX-$OBF_BASE_ARCH-$OBF_BUILD_NUMBER-$OBF_BUILD_DATE.tar.bz2 ]; then

        echo "packaging JDK"
        cp $OBF_DROP_DIR/jdk$FILENAME_PREFIX-$OBF_BASE_ARCH-$OBF_BUILD_NUMBER-$OBF_BUILD_DATE.tar.bz2 SOURCES/jdk.tar.bz2

        if [ "$XPACKAGE_MODE" = "generic" ]; then
            tar -xjf SOURCES/jdk.tar.bz2 -C TEMP

            find TEMP/jdk -name '*.diz' | xargs rm
            (cd TEMP/jdk && rm -rf demo sample man src.zip)

            REVISION=$(echo $OBF_BUILD_NUMBER | sed 's/^u\(.*\)-b.*$/\1/')
            JDK_DIR="jdk11.0.5_$REVISION"
            mv TEMP/jdk TEMP/$JDK_DIR
            tar -cJf GENERIC/$PACKAGE_NAME-$OBF_BASE_ARCH-11.0.5_$OBF_BUILD_NUMBER.tar.xz -C TEMP $JDK_DIR
        else
            rpmbuild -bb --define="_topdir $PWD" --define="_tmppath $PWD/TEMP" --define="jvm_version $OBF_BUILD_NUMBER" \
                         --define="jdk_type $FILENAME_PREFIX" --define="jdk_model $OBF_JDK_MODEL" --define="cum_jdk 0" \
                         SPECS/jdk.spec
        fi

        if [ $? != 0 ]; then
            exit -1
        fi

    else
        echo "missing JDK image tarball $OBF_DROP_DIR/jdk$FILENAME_PREFIX-$OBF_BASE_ARCH-$OBF_BUILD_NUMBER-$OBF_BUILD_DATE.tar.bz2, skipping packaging"
    fi

    if [ -f $OBF_DROP_DIR/jre$FILENAME_PREFIX-$OBF_BASE_ARCH-$OBF_BUILD_NUMBER-$OBF_BUILD_DATE.tar.bz2 ]; then

        echo "packaging JRE"
        cp $OBF_DROP_DIR/jre$FILENAME_PREFIX-$OBF_BASE_ARCH-$OBF_BUILD_NUMBER-$OBF_BUILD_DATE.tar.bz2 SOURCES/jre.tar.bz2

        if [ "$XPACKAGE_MODE" = "generic" ]; then
            echo "No generic JRE packaging yet."
        else
            rpmbuild -bb --define="_topdir $PWD" --define="_tmppath $PWD/TEMP" --define="jvm_version $OBF_BUILD_NUMBER" \
                       --define="jdk_type $FILENAME_PREFIX" --define="jdk_model $OBF_JDK_MODEL" --define="cum_jdk 0" \
                       SPECS/jre.spec
        fi

        if [ $? != 0 ]; then
            exit -1
        fi

    else
        echo "missing JRE image tarball $OBF_DROP_DIR/jre$FILENAME_PREFIX-$OBF_BASE_ARCH-$OBF_BUILD_NUMBER-$OBF_BUILD_DATE.tar.bz2, skipping packaging"
    fi

    if [ "$XPACKAGE_MODE" = "generic" ]; then
        mv GENERIC/*.tar.xz $OBF_DROP_DIR
    else
        mv RPMS/*/*.rpm $OBF_DROP_DIR
    fi

fi
