#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)/../"  
source $DIR/cqsw-paas-config.sh
##Change Docker config
cat > /etc/docker/daemon.json << EOF
{   "registry-mirrors": ["https://dockerproxy.com"],
    "exec-opts": ["native.cgroupdriver=systemd"],
    "insecure-registries": ["$Harbor_IP"]
}
EOF
systemctl daemon-reload
systemctl restart docker
##Login Docker Harbor
docker login $Harbor_IP -uadmin -pHarbor12345
##Join Kubernetes cluster
Token="sha256:${Discovery_token_ca_cert_HASH}"
kubeadm join $Master_IP:6443 --token cqswxy.cqswcloudcompute --discovery-token-ca-cert-hash $Token --cri-socket unix:///var/run/cri-dockerd.sock

