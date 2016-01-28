#!/bin/bash

ip=$(ifconfig | grep 192.168.175 | cut -d: -f2 | awk '{ print $1}')
echo "consul agent -data-dir /tmp/consul -node=$(hostname) -bind=${ip} -config-dir /etc/consul">> /home/vagrant/run_consul.sh

chmod 755 /home/vagrant/run_consul.sh
/home/vagrant/run_consul.sh &> /home/vagrant/run_consul.log &

until grep 'Consul agent running' /home/vagrant/run_consul.log
do
  sleep 1
done

consul join 192.168.175.100
