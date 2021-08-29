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

#Installing puredns and shuffledns
GO111MODULE=on go get github.com/d3mondev/puredns/v2
GO111MODULE=on go get -v github.com/projectdiscovery/shuffledns/cmd/shuffledns

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

#Instaling dnsvalidator for valid resolvers
git clone https://github.com/vortexau/dnsvalidator.git /root/tools/dnsvalidator
cd /root/tools/dnsvalidator/ && python3 setup.py install
dnsvalidator -tL https://public-dns.info/nameservers.txt -threads 25 -o /root/tools/resolvers.txt
cd /root/tools

#Installing whatweb, nikto and wpscan
gem install bundler && bundle update
apt install nikto whatweb -y
gem install wpscan

#Installing notify
GO111MODULE=on go get -v github.com/projectdiscovery/notify/cmd/notify

#Installing subdomain enumeration tools
GO111MODULE=on go get -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder
GO111MODULE=on go get -v github.com/projectdiscovery/chaos-client/cmd/chaos
go get -u github.com/tomnomnom/assetfinder
go get -v github.com/OWASP/Amass/v3/...
go get github.com/cgboal/sonarsearch/crobat
git clone https://github.com/findomain/findomain.git /root/tools/findomain
cd /root/tools/findomain/ && cargo build --release
cp target/release/findomain /usr/bin/ && cd /root/tools

#Installing altdns and dnsgen
pip3 install py-altdns
pip3 install dnsgen

#Installing anew, unfurl, antiburl, qsreplace and urinteresting
git clone https://github.com/tomnomnom/hacks.git /root/tools/tomnomnom-hacks
go build /root/tools/tomnomnom-hacks/anti-burl/main.go
mv /root/tools/tomnomnom-hacks/anti-burl/main /usr/local/bin/antiburl
go get -u github.com/tomnomnom/unfurl
go get -u github.com/tomnomnom/qsreplace
go get -u github.com/tomnomnom/anew
go build /root/tools/tomnomnom-hacks/urinteresting/main.go
mv /root/tools/tomnomnom-hacks/urinteresting/main /usr/local/bin/urinteresting

#Installing gf for potentially vulnerable parameter and enpoint detection
mkdir /root/.gf
git clone https://github.com/tomnomnom/gf.git /root/tools/gf
cd /root/tools/gf/ && go build /root/tools/gf/main.go
mv /root/tools/gf/main /usr/local/bin/gf
mv /root/tools/gf/examples/*.json /root/.gf/
rm -rf /root/tools/gf/
git clone https://github.com/1ndianl33t/Gf-Patterns /root/tools/Gf-Patterns
mv /root/tools/Gf-Patterns/*.json /root/.gf/
rm -rf /root/tools/Gf-Patterns

#Installing sqlmap and nosqlmap for SQLi
apt-get install sqlmap -y && sqlmap --update
git clone https://github.com/codingo/NoSQLMap.git /root/tools/nosqlmap
python3 /root/tools/nosqlmap/setup.py install

#Installing tplmap for SSTi
git clone https://github.com/epinna/tplmap.git /root/tools/tplmap
pip3 install -r /root/tools/tplmap/requirements.txt
