# Modified OBuildFactory

This is a stripped version of OBuildFactory to be able to compile and install the OpenJDK11

## Prerequisites

For ubuntu :

``` shell
sudo apt-get install git mercurial zip bzip2 unzip tar curl autoconf
sudo apt-get install ccache make gcc g++ ca-certificates ca-certificates-java
sudo apt-get install libx11-dev libxext-dev libxrender-dev libxtst-dev libxt-dev libxrandr-dev libxt-dev libfontconfig1-dev
sudo apt-get install libasound2-dev libcups2-dev libfreetype6-dev
sudo apt-get install build-essential ruby ruby-dev
sudo apt-get install openjdk-11-jdk
sudo apt-get install pkg-config
sudo gem install fpm
```

## Environments

- Set `OBF_JAVA11_HOME` to the home directory of your OpenJDK11

## Authors
- Henri Gomez (https://github.com/hgomez)
- Ray Andrew (https://github.com/rayandrews)
