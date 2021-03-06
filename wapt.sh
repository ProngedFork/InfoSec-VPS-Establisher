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

#Installing h2i for host to ip conversion
go get -u github.com/cybercdh/h2i

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

#Installing whatweb, nikto, nettacker wpscan and wordpress-exploit-framework
gem install bundler && bundle update
apt install nikto whatweb -y
gem install wpscan
gem install wpxf
git clone https://github.com/OWASP/Nettacker.git /root/tools/nettacker && cd /root/tools/nettacker
pip3 install -r /root/tools/nettacker/requirements.txt && python3 /root/tools/nettacker/setup.py install

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

#Install altdns, goaltdns and dnsgen
pip3 install py-altdns
pip3 install dnsgen
go get github.com/subfinder/goaltdns

#Installing anew, unfurl, antiburl, qsreplace and urinteresting
git clone https://github.com/tomnomnom/hacks.git /root/tools/tomnomnom-hacks
cd /root/tools/tomnomnom-hacks/ && go build /root/tools/tomnomnom-hacks/anti-burl/main.go
mv /root/tools/tomnomnom-hacks/anti-burl/main /usr/local/bin/antiburl
go get -u github.com/tomnomnom/unfurl
go get -u github.com/tomnomnom/qsreplace
go get -u github.com/tomnomnom/anew
cd /root/tools/tomnomnom-hacks/ && go build /root/tools/tomnomnom-hacks/urinteresting/main.go
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

#Installing ssrfmap for SSRF
git clone https://github.com/swisskyrepo/SSRFmap.git /root/tools/ssrfmap
pip3 install -r /root/tools/ssrfmap/requirements.txt

#Installing gitrob, trufflehog, github-search, git-secrets and gitgraber for GitHub reconnaissance
cd /root/tools/ && wget https://github.com/michenriksen/gitrob/releases/download/v2.0.0-beta/gitrob_linux_amd64_2.0.0-beta.zip
unzip gitrob_linux_amd64_2.0.0-beta.zip
rm gitrob_linux_amd64_2.0.0-beta.zip README.md && mv gitrob /usr/local/bin/
pip3 install truffleHog
git clone https://github.com/gwen001/github-search.git /root/tools/github-search-gwen
go get github.com/eth0izzle/shhgit
git clone https://github.com/awslabs/git-secrets.git /root/tools/git-secrets
cd /root/tools/git-secrets/ && make install
git clone https://github.com/hisxo/gitGraber.git /root/tools/gitgraber
pip3 install -r /root/tools/gitgraber/requirements.txt
git clone https://github.com/obheda12/GitDorker.git /root/tools/gitdorker
pip3 install -r /root/tools/gitdorker/requirements.txt

#Installing subjs, getjs, secretfinder, jsfinder and linkfinder for JS reconnaissance
GO111MODULE=on go get -u -v github.com/lc/subjs
go get github.com/003random/getJS
git clone https://github.com/m4ll0k/SecretFinder.git /root/tools/secretfinder
pip3 install -r /root/tools/secretfinder/requirements.txt
git clone https://github.com/Threezh1/JSFinder.git /root/tools/jsfinder
git clone https://github.com/GerbenJavado/LinkFinder.git /root/tools/linkfinder
python3 /root/tools/linkfinder/setup.py install
pip3 install -r /root/tools/linkfinder/requirements.txt

#Installing page-fetch and wadl-dumper
go get github.com/detectify/page-fetch
go get github.com/dwisiswant0/wadl-dumper

#Installing crlfuzz for CRLFi
GO111MODULE=on go get -v github.com/dwisiswant0/crlfuzz/cmd/crlfuzz
git clone https://github.com/MichaelStott/CRLF-Injection-Scanner.git /root/tools/crlf-scanner
python3 /root/tools/crlf-scanner/setup.py install

#Install subover, nthim, subzy and subjack for STKO
go get github.com/Ice3man543/SubOver
cargo install NtHiM
go get -u -v github.com/lukasikic/subzy
go install -v github.com/lukasikic/subzy@latest
go get github.com/haccer/subjack

#Installing dalfox, PwnXSS, gxss, kxss, xsstrike and xspear for XSS
GO111MODULE=on go get -v github.com/hahwul/dalfox/v2
go get github.com/Emoe/kxss
go get -u github.com/KathanP19/Gxss
git clone https://github.com/pwn0sec/PwnXSS /root/tools/pwnxss && chmod 755 -R /root/tools/pwnxss
git clone https://github.com/s0md3v/XSStrike.git /root/tools/xsstrike
pip3 install -r /root/tools/xsstrike/requirements.txt
gem install colorize
gem install selenium-webdriver
gem install terminal-table
gem install progress_bar
gem install XSpear

#Installing cmseek for CMS detection
git clone https://github.com/Tuhinshubhra/CMSeeK.git /root/tools/cmseek
pip3 install -r /root/tools/cmseek/requirements.txt

#Installing interlace for multithreading
git clone https://github.com/codingo/Interlace.git /root/tools/interlace
cd /root/tools/interlace && pip3 install -r /root/tools/interlace/requirements.txt
python3 /root/tools/interlace/setup.py install
