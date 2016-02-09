#!/bin/bash

mkdir -p /etc/systemd/system/docker.service.d

cat <<'ServiceConfig' > /etc/systemd/system/docker.service.d/overlay.conf
[Service]
EnvironmentFile=/run/flannel/subnet.env

ExecStart=
ExecStart=/usr/bin/docker daemon -H fd:// --bip=${FLANNEL_SUBNET} --mtu=${FLANNEL_MTU} -D
ServiceConfig

systemctl daemon-reload
systemctl stop flanneld

if [ ! -z "$1" ]; then
systemctl stop etcd
fi
systemctl restart docker
if [ ! -z "$1" ]; then
systemctl start etcd
fi
systemctl start flanneld
