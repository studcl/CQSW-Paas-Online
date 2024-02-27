#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)/../"  
source $DIR/cqsw-paas-config.sh
Tar_DIR="$(cd "$(dirname "$0")" && pwd)"
##Install Docker Harbor
tar -zxvf $Tar_DIR/harbor-online-installer-v2.10.0.tgz
Harbor_DIR="$(cd "$(dirname "$0")" && pwd)/harbor"
cp $Harbor_DIR/harbor.yml.tmpl $Harbor_DIR/harbor.yml
sed -i "s/hostname: .*/hostname: $Harbor_IP/g" $Harbor_DIR/harbor.yml
sed -i '13,18s/^/#/' $Harbor_DIR/harbor.yml
$Harbor_DIR/install.sh
