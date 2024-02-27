#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)/../"  
source $DIR/cqsw-paas-config.sh
Harbor_DIR="$(cd "$(dirname "$0")" && pwd)/harbor"
docker-compose -f $Harbor_DIR/docker-compose.yml stop
##Config Docker
cat > /etc/docker/daemon.json << EOF 
{   "registry-mirrors": ["https://dockerproxy.com"],
    "exec-opts": ["native.cgroupdriver=systemd"],
    "insecure-registries": ["$Harbor_IP"]
}
EOF
systemctl enable docker
systemctl restart docker

##Restart Docker Harbor
docker-compose -f $Harbor_DIR/docker-compose.yml up -d
echo "登录网页：$Harbor_IP"
echo "账号：admin"
echo "密码：Harbor12345"
