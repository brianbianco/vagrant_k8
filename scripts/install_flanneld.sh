#!/bin/bash

wget -nv https://github.com/coreos/flannel/releases/download/v0.5.5/flannel-0.5.5-linux-amd64.tar.gz
tar zxvf flannel-0.5.5-linux-amd64.tar.gz
cp flannel-0.5.5/flanneld /usr/local/bin/

cat << EOF > /lib/systemd/system/flanneld.service
[Unit]
Description=flanneld

[Service]
Type=simple
ExecStart=/usr/local/bin/flanneld --etcd-endpoints=http://192.168.175.100:4001 --iface=eth1
EOF

if [ ! -z "$1" ]; then
  cat << EOF > ./flannel.json
{
  "Network": "10.254.0.0/16",
  "SubnetLen": 24,
  "SubnetMin": "10.254.50.0",
  "SubnetMax": "10.254.199.0",
  "Backend": {
    "Type": "vxlan",
    "VNI": 1
  }
}
EOF

  curl -s -L http://192.168.175.100:4001/v2/keys/coreos.com/network/config -XPUT --data-urlencode value@./flannel.json
fi

systemctl start flanneld

