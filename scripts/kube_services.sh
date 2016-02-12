#!/bin/bash

cat << EOF > /lib/systemd/system/kube-apiserver.service
[Unit]
Description=Kubernetes API Server

[Service]
Type=simple
ExecStart=/usr/local/bin/hyperkube apiserver --cluster-name=slurm --etcd-servers=http://192.168.175.100:4001 --service-cluster-ip-range=10.254.0.0/16 --token-auth-file=/dev/null --insecure-bind-address=0.0.0.0 --advertise-address=192.168.175.100
EOF

cat << EOF > /lib/systemd/system/kube-scheduler.service
[Unit]
Description=Kubernetes Scheduler

[Service]
Type=simple
ExecStart=/usr/local/bin/hyperkube scheduler --address=0.0.0.0 --master=192.168.175.100:8080
EOF

cat << EOF > /lib/systemd/system/kube-controller.service
[Unit]
Description=Kubernetes Master Controller

[Service]
Type=simple
ExecStart=/usr/local/bin/hyperkube controller-manager —address=0.0.0.0 --master=192.168.175.100:8080
EOF

cat << EOF > /lib/systemd/system/kube-proxy.service
[Unit]
Description=Kubernetes Proxy

[Service]
Type=simple
ExecStart=/usr/local/bin/hyperkube proxy --master=192.168.175.100:8080 --v=4
EOF

cat << EOF > /lib/systemd/system/kubelet.service
[Unit]
Description=Kubernetes Kubelet

[Service]
Type=simple
ExecStart=/usr/local/bin/hyperkube kubelet --api-servers=http://192.168.175.100:8080 --config=/etc/kubernetes/manifests —register-node=true
EOF

if [ ! -z "$1" ]; then
  systemctl start kube-apiserver
  systemctl start kube-scheduler
  systemctl start kube-controller
fi

systemctl start kube-proxy
systemctl start kubelet
