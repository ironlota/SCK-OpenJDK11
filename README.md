# SCK-OpenJDK11

OpenJDK11 for SCK purposes.

The installer is a stripped version of OBuildFactory to be able to compile and install the OpenJDK11

## Prerequisites

For ubuntu :

```shell
sudo apt-get install git mercurial zip bzip2 unzip tar curl autoconf
sudo apt-get install ccache make gcc g++ ca-certificates ca-certificates-java
sudo apt-get install libx11-dev libxext-dev libxrender-dev libxtst-dev libxt-dev libxrandr-dev libxt-dev libfontconfig1-dev
sudo apt-get install libasound2-dev libcups2-dev libfreetype6-dev
sudo apt-get install build-essential ruby ruby-dev
sudo apt-get install openjdk-11-jdk
sudo apt-get install pkg-config
sudo gem install fpm
```

If the package `openjdk-11-jdk` is not found in apt repository, run this :

```shell
sudo add-apt-repository ppa:openjdk-r/ppa \
&& sudo apt-get update -q \
&& sudo apt install -y openjdk-11-jdk
```

## Environments

- Set `OBF_JAVA11_HOME` to the home directory of your OpenJDK11

> Or just run `source environment.sh` if you run it on Ubuntu based machine

## How to compile

1. For the first time, run

```shell
./build.sh
```

2. After that just run :

```shell
./compile-fast.sh
```

