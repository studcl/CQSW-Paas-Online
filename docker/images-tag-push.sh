#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)/../"
source $DIR/cqsw-paas-config.sh
Harbor_URL="${Harbor_IP}/library"
##Tag images

docker tag registry.k8s.io/kube-controller-manager:v1.29.0 "$Harbor_URL/kube-controller-manager:v1.29.0"
docker tag registry.k8s.io/kube-proxy:v1.29.0 "$Harbor_URL/kube-proxy:v1.29.0"
docker tag registry.k8s.io/etcd:3.5.10-0 "$Harbor_URL/etcd:3.5.10-0"
docker tag registry.k8s.io/pause:3.6 "$Harbor_URL/pause:3.6"
docker tag registry.k8s.io/kube-apiserver:v1.29.0 "$Harbor_URL/kube-apiserver:v1.29.0"
docker tag registry.k8s.io/coredns/coredns:v1.11.1 "$Harbor_URL/coredns:v1.11.1"
docker tag registry.k8s.io/kube-scheduler:v1.29.0 "$Harbor_URL/kube-scheduler:v1.29.0"
docker tag registry.k8s.io/pause:3.9 "$Harbor_URL/pause:3.9"
##Login Docker Harbor 
docker login "$Harbor_IP" -u admin -p Harbor12345

##Push images
docker push "$Harbor_URL/kube-apiserver:v1.29.0"
docker push "$Harbor_URL/kube-controller-manager:v1.29.0"
docker push "$Harbor_URL/kube-scheduler:v1.29.0"
docker push "$Harbor_URL/kube-proxy:v1.29.0"
docker push "$Harbor_URL/coredns:v1.11.1"
docker push "$Harbor_URL/pause:3.9"
docker push "$Harbor_URL/etcd:3.5.10-0"
docker push "$Harbor_URL/pause:3.6"
