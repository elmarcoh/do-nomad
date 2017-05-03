#!/bin/sh
set -e

apt-get update -y
apt-get install -y unzip curl wget

sudo curl -sSL https://get.docker.com/ | sh

cd /tmp
wget https://releases.hashicorp.com/nomad/0.5.6/nomad_0.5.6_linux_amd64.zip?_ga=1.249323911.1804587465.1488413062 -O nomad.zip
wget https://releases.hashicorp.com/consul/0.8.1/consul_0.8.1_linux_amd64.zip?_ga=1.105245379.1788266624.1492878418 -O consul.zip

echo "Installing consuli..."
unzip consul.zip
chmod +x consul
mv consul /usr/bin/consul

systemctl start consul.service
systemctl enable consul.service

echo "Installing nomad..."
unzip nomad.zip
chmod +x nomad
mv nomad /usr/bin/nomad

wget https://raw.githubusercontent.com/hashicorp/nomad/master/dist/systemd/nomad.service
mv nomad.service /etc/systemd/system/nomad.service

local_ip=`hostname -I|cut -d' ' -f3`
sed "s/\$local_ip/$local_ip/" /etc/nomad/*.hcl -i
sed "s/\$local_ip/$local_ip/" /etc/consul/*.json -i

systemctl start nomad.service
systemctl enable nomad.service
