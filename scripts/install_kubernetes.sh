#!/bin/bash

apt-get install bridge-utils

K8_V=v1.1.7

wget -nv https://github.com/kubernetes/kubernetes/releases/download/$K8_V/kubernetes.tar.gz
tar zxvf kubernetes.tar.gz
cd kubernetes/server
tar zxvf kubernetes-server-linux-amd64.tar.gz
cp kubernetes/server/bin/hyperkube /usr/local/bin/
cp kubernetes/server/bin/kubectl /usr/local/bin/

ETCD_V=$(cat ../cluster/images/etcd/Makefile | grep 'ETCD_VERSION =' | cut -f3 -d' ')

HYPERKUBE_IMAGE=gcr.io/google_containers/hyperkube:$K8_V
ETCD_IMAGE=gcr.io/google_containers/etcd:$ETCD_V

docker pull $HYPERKUBE_IMAGE
docker pull $ETCD_IMAGE

mkdir -p /etc/kubernetes/manifests
chown -R vagrant /etc/kubernetes
