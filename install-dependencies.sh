#!/bin/bash

echo "Installing dependencies"

sudo apt-get install -y software-properties-common
sudo add-apt-repository ppa:openjdk-r/ppa \
    && sudo apt-get update -q
sudo apt-get install -y git mercurial zip bzip2 unzip tar curl autoconf
sudo apt-get install -y ccache make gcc g++ ca-certificates ca-certificates-java
sudo apt-get install -y libx11-dev libxext-dev libxrender-dev libxtst-dev libxt-dev libxrandr-dev libxt-dev libfontconfig1-dev
sudo apt-get install -y libasound2-dev libcups2-dev libfreetype6-dev
sudo apt-get install -y build-essential ruby ruby-dev
sudo apt install -y openjdk-11-jdk
sudo apt-get install -y pkg-config
sudo gem install fpm

echo "Done installing dependencies"
