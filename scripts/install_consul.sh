#!/bin/bash

sudo apt-get install unzip
wget -nv https://releases.hashicorp.com/consul/0.6.3/consul_0.6.3_linux_amd64.zip
unzip consul_0.6.3_linux_amd64.zip
mv consul /usr/local/bin
mkdir /etc/consul
mkdir /tmp/consul
chown vagrant /etc/consul
chown vagrant /tmp/consul
