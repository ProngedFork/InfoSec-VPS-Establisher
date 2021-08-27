#!/bin/bash

#Updating the box
apt-get update

#Creating necessary directories
mkdir -p tools
mkdir -p recon

#Installing Aquatone for taking screenshots
cd /root/tools/
wget https://github.com/michenriksen/aquatone/releases/download/v1.4.3/aquatone_linux_amd64_1.4.3.zip
unzip aquatone_linux_amd64_1.4.3.zip
mv aquatone /usr/local/bin/
rm aquatone_linux_amd64_1.4.3.zip LICENSE.txt README.md
gem install aquatone
