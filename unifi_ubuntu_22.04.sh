#!/bin/bash
#
# Install Unifi Network Server on Ubuntu 22.04.3 LTS
# 
#

apt-get update
apt-get upgrade -y
apt-get update
wget http://archive.ubuntu.com/ubuntu/pool/main/o/openssl/libssl1.1_1.1.1f-1ubuntu2_amd64.deb -O libssl1.1.deb
dpkg -i libssl1.1.deb
gpg --gen-key
gpg -list-keys
apt install curl haveged gpg openjdk-8-jre-headless -y

apt-cache policy
curl https://dl.ui.com/unifi/unifi-repo.gpg | sudo tee /usr/share/keyrings/ubiquiti-archive-keyring.gpg >/dev/null
echo 'deb [signed-by=/usr/share/keyrings/ubiquiti-archive-keyring.gpg] https://www.ui.com/downloads/unifi/debian stable ubiquiti' | sudo tee /etc/apt/sources.list.d/100-ubnt-unifi.list > /dev/null

curl https://pgp.mongodb.com/server-4.4.asc | sudo gpg --dearmor | sudo tee /usr/share/keyrings/mongodb-org-server-4.4-archive-keyring.gpg >/dev/null
echo 'deb [arch=amd64,arm64 signed-by=/usr/share/keyrings/mongodb-org-server-4.4-archive-keyring.gpg] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/4.4 multiverse' | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list > /dev/null
sudo apt-get update
sudo apt-get install -y mongodb-org-server

sudo systemctl enable mongod && sudo systemctl start mongod
sudo apt-get update && sudo apt-get install unifi -y
sudo systemctl enable unifi && sudo systemctl restart unifi
