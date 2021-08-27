#!/bin/bash

#Updating and upgrading the box
apt-get update && apt-get dist-upgrade -y 

#Downloading Go-Lang v1.17
wget https://golang.org/dl/go1.17.linux-amd64.tar.gz
tar -xvf go1.17.linux-amd64.tar.gz
mv go /usr/local
rm go1.17.linux-amd64.tar.gz

#Setting up path for Go-Lang
echo "export GOROOT=/usr/local/go" >> ~/.bashrc
echo "export GOPATH=$HOME/go" >> ~/.bashrc
echo "export PATH=$GOPATH/bin:$GOROOT/bin:$PATH" >> ~/.bashrc
