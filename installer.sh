#!/bin/bash

#Updating the box and creating necessary directories
apt-get update && mkdir -p /root/tools /root/recon

#Installing Aquatone for taking screenshots
cd /root/tools/ && wget https://github.com/michenriksen/aquatone/releases/download/v1.4.3/aquatone_linux_amd64_1.4.3.zip
unzip aquatone_linux_amd64_1.4.3.zip
mv aquatone /usr/local/bin/
rm aquatone_linux_amd64_1.4.3.zip LICENSE.txt README.md
gem install aquatone

#Installing Eyewitness for taking screenshots
git clone https://github.com/FortyNorthSecurity/EyeWitness.git /root/tools/eyewitness
bash /root/tools/eyewitness/Python/setup/setup.sh

#Installing httpx, httprobe and meg
GO111MODULE=on go get -v github.com/projectdiscovery/httpx/cmd/httpx
go get -u github.com/tomnomnom/httprobe
go get -u github.com/tomnomnom/meg

#Installing Waybackurls and gau
go get github.com/tomnomnom/waybackurls
GO111MODULE=on go get -u -v github.com/lc/gau

#Installing nuclei, nuclei-templates and cent
GO111MODULE=on go get -v github.com/projectdiscovery/nuclei/v2/cmd/nuclei
nuclei -ut
GO111MODULE=on go get -u github.com/xm1k3/cent
cent init
cent -p /root/nuclei-templates/cent-nuclei-templates -k

#Installing interactsh server
GO111MODULE=on go get -v github.com/projectdiscovery/interactsh/cmd/interactsh-client

#Installing puredns
GO111MODULE=on go get github.com/d3mondev/puredns/v2

#Installing hakrawler and gospider
go install github.com/hakluke/hakrawler@latest
GO111MODULE=on go get -u github.com/jaeles-project/gospider

#Installing ffuf and dirsearch
go get -u github.com/ffuf/ffuf
git clone https://github.com/maurosoria/dirsearch.git /root/tools/dirsearch
pip3 install -r /root/tools/dirsearch/requirements.txt

#Installing Seclists and Assetnote wordlists
git clone https://github.com/danielmiessler/SecLists.git /root/tools/seclists
wget -r --no-parent -R "index.html*" https://wordlists-cdn.assetnote.io/data/ -nH
mv data /root/tools/assetnote-dict

#Installing nmap, masscan, naabu and massdns
apt-get install nmap masscan -y
GO111MODULE=on go get -v github.com/projectdiscovery/naabu/v2/cmd/naabu
git clone https://github.com/blechschmidt/massdns.git /root/tools/massdns
cd /root/tools/massdns && make
make install && cd /root/tools
