#!/bin/sh

apt-get update -y
apt-get install -y unzip curl wget

sudo curl -sSL https://get.docker.com/ | sh

cd /tmp
wget https://releases.hashicorp.com/nomad/0.5.6/nomad_0.5.6_linux_amd64.zip?_ga=1.249323911.1804587465.1488413062 -O nomad.zip
unzip nomad.zip
chmod +x nomad
mv nomad /usr/bin/nomad

wget https://raw.githubusercontent.com/hashicorp/nomad/master/dist/systemd/nomad.service
mv nomad.service /etc/systemd/system/nomad.service
mkdir /etc/nomad
systemctl start nomad.service
