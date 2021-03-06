#!/bin/bash

#Updating and upgrading the box
apt-get update && apt-get dist-upgrade -y
apt-get install build-essential -y

#Downloading Go-Lang v1.17
wget https://go.dev/dl/go1.17.3.linux-amd64.tar.gz
tar -xvf go1.17.3.linux-amd64.tar.gz
mv go /usr/local
rm go1.17.3.linux-amd64.tar.gz

#Setting up path for Go-Lang
echo "export GOROOT=/usr/local/go" >> ~/.bashrc
echo "export GOPATH=\$HOME/go" >> ~/.bashrc
echo "export PATH=\$GOPATH/bin:\$GOROOT/bin:\$PATH" >> ~/.bashrc

#Installing python3, pip3 and additional python based dependencies
apt-get install python2 python3 python3-pip python-dev python3-dev -y

#Installing ruby
apt-get install ruby libopenssl-ruby ruby-dev zlib1g-dev liblzma-dev libsqlite3-dev -y

#Installing perl
apt-get install perl -y

#Installing additional dependencies
apt-get install screen tree git libcurl4-openssl-dev libssl-dev libpq-dev -y

#Installing Chromium and fdupes
apt install chromium-browser fdupes -y

#Installing rust => proceed with option 1
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

#Installing bs4
pip3 install bs4
