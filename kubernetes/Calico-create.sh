#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)/../"
source $DIR/cqsw-paas-config.sh 
Calico_DIR="$(cd "$(dirname "$0")" && pwd)/calico"
kubectl apply -f $Calico_DIR/tigera-operator.yaml --server-side
sed -i "s/cidr: .*/cidr: $Pod_Network_CIDR/" $Calico_DIR/custom-resources.yaml
kubectl apply -f $Calico_DIR/custom-resources.yaml
