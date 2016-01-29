#!/bin/bash

mkdir -p /etc/systemd/system/docker.service.d

cat <<ServiceConfig > /etc/systemd/system/docker.service.d/overlay.conf
[Service]
ExecStart=
ExecStart=/usr/bin/docker daemon -H fd:// --cluster-store=consul://localhost:8500 --cluster-advertise=eth1:2376 -D
ServiceConfig

systemctl daemon-reload
systemctl restart docker

if ! docker network ls | grep k8; then
  docker network create --driver overlay k8
fi
