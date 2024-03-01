#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)/../"  
source $DIR/cqsw-paas-config.sh
Tar_DIR="$(cd "$(dirname "$0")" && pwd)"
##Install Docker Harbor
if [ ! -e "$Tar_DIR/harbor-offline-installer-v2.10.0.tgz" ]; then  
            wget https://github.com/goharbor/harbor/releases/download/v2.10.0/harbor-offline-installer-v2.10.0.tgz  
fi
mv harbor-offline-installer-v2.10.0.tgz $Tar_DIR/harbor-offline-installer-v2.10.0.tgz
tar -zxvf $Tar_DIR/harbor-offline-installer-v2.10.0.tgz
Harbor_DIR="$(cd "$(dirname "$0")" && pwd)/harbor"
cp $Harbor_DIR/harbor.yml.tmpl $Harbor_DIR/harbor.yml
sed -i "s/hostname: .*/hostname: $Harbor_IP/g" $Harbor_DIR/harbor.yml
sed -i '13,18s/^/#/' $Harbor_DIR/harbor.yml
$Harbor_DIR/install.sh
