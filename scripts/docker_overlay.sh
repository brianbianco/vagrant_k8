#!/bin/bash

sed -ri "/^#DOCKER_OPTS=/d" /etc/default/docker
echo 'DOCKER_OPTS="--cluster-store=consul://localhost:8500 --cluster-advertise=eth1:2376"' >> /etc/default/docker
service docker restart

if ! docker network ls | grep k8; then
  docker network create --driver overlay k8
fi
