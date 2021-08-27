#!/bin/bash

#Updating and upgrading the box
apt-get update && apt-get dist-upgrade -y 

#Creating necessary directories
mkdir -p tools
mkdir -p recon

#Downloading Go-Lang v1.17
wget https://golang.org/dl/go1.17.linux-amd64.tar.gz
tar -xvf go1.17.linux-amd64.tar.gz
mv go /usr/local
rm go1.17.linux-amd64.tar.gz

#Setting up path for Go-Lang
export GOROOT=/usr/local/go;
export GOPATH=$HOME/go;
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH;
