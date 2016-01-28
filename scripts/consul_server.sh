#!/bin/bash

echo "consul agent -server -bootstrap-expect 1 -data-dir /tmp/consul -node=controller -bind=192.168.175.100 -config-dir /etc/consul" >> /home/vagrant/run_consul.sh
chmod 755 /home/vagrant/run_consul.sh

/home/vagrant/run_consul.sh &> /home/vagrant/run_consul.log &
