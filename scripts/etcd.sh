#!/bin/bash

ETCD_V=$(cat kubernetes/cluster/images/etcd/Makefile | grep 'ETCD_VERSION =' | cut -f3 -d' ')

ETCD_IMAGE=gcr.io/google_containers/etcd:$ETCD_V

mkdir -p /var/etcd/data

cat << EOF > /lib/systemd/system/etcd.service
[Unit]
Description=etcd

[Service]
Type=simple
ExecStart=/usr/bin/docker run --rm --name=etcd -p 4001:4001 -v /var/etcd/data:/var/etcd/data $ETCD_IMAGE /usr/local/bin/etcd --addr=127.0.0.1:4001 --bind-addr=0.0.0.0:4001 --data-dir=/var/etcd/data -vv
EOF

systemctl start etcd
