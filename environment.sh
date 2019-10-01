#!/bin/bash

echo "Setting SCK OpenJDK11 development"

export CC="ccache gcc"
export CXX="ccache g++"
export OBF_JAVA11_HOME="/usr/lib/jvm/java-11-openjdk-amd64"

path_dir="${PWD}/sources/build/linux-x86_64-normal-server-release/jdk/bin"

_dev_java="${path_dir}/java -verbose:gc"
_dev_java_ksm="${_dev_java} -XX:+UseKSM"
_dev_javac="${path_dir}/javac"

alias dev_javac="${_dev_javac}"
alias dev_java="${_dev_java}"
alias dev_java_serial="${_dev_java} -XX:+UseSerialGC"
alias dev_java_ksm="${_dev_java_ksm}"
alias dev_java_ksm_serial="${_dev_java_ksm} -XX:+UseSerialGC"

echo "Setting succeed"
