#!/bin/bash

#Updating and upgrading the box
apt-get update && apt-get dist-upgrade -y
apt-get install build-essential -y

#Downloading Go-Lang v1.17
wget https://golang.org/dl/go1.17.linux-amd64.tar.gz
tar -xvf go1.17.linux-amd64.tar.gz
mv go /usr/local
rm go1.17.linux-amd64.tar.gz

#Setting up path for Go-Lang
echo "export GOROOT=/usr/local/go" >> ~/.bashrc
echo "export GOPATH=\$HOME/go" >> ~/.bashrc
echo "export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH" >> ~/.bashrc

#Installing python3 and pip3
apt-get install python3 python3-pip -y

#Installing ruby
apt-get install ruby libopenssl-ruby ruby-dev -y

#Installing perl
apt-get install perl -y

#Installing additional dependencies
apt-get install screen git -y

#Installing Chromium
apt install chromium-browser

#Installing rust => proceed with option 1
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
source $HOME/.cargo/env
