#!/usr/bin/env bash


## Install Security Tools
sudo apt-get install tor nmap skipfish john


## Install Other Security Tools
pip install sqlmap


## Download GitPillage
wget https://raw.githubusercontent.com/evilpacket/DVCS-Pillage/master/gitpillage.sh


## Install Wireless Tools
sudo apt-get install aircrack-ng reaver macchanger wifiphisher pixiewps

# Use wifite2 from git, (Old Version: sudo apt-get install wifite)
git clone https://github.com/derv82/wifite2.git
cd wifite2
sudo python setup.py install


# use reaver with pixiewps


## Install Password Cracking Tools
git clone https://github.com/hashcat/hashcat.git
cd hashcat
sudo make & sudo make install

git clone https://github.com/ZerBea/hcxtools.git 
cd hcxtools
sudo make & sudo make install

git clone https://github.com/ZerBea/hcxdumptool.git
cd hcxdumptool
sudo make & sudo make install

git clone https://github.com/aanarchyy/bully
cd bully/src
sudo make & sudo make install


## Download SearchSploit
sudo git clone --depth=1 https://github.com/offensive-security/exploitdb.git ~/tools/exploitdb

sed 's|path_array+=(.*)|path_array+=("~/tools/exploitdb")|g' ~/tools/exploitdb/.searchsploit_rc > ~/.searchsploit_rc

sudo ln -sf ~/tools/exploitdb/searchsploit /usr/local/bin/searchsploit