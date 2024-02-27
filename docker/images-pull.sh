#!/bin/bash
#原镜像
#registry.k8s.io/kube-apiserver:v1.29.0
#registry.k8s.io/kube-controller-manager:v1.29.0
#registry.k8s.io/kube-scheduler:v1.29.0
#registry.k8s.io/kube-proxy:v1.29.0
#registry.k8s.io/coredns/coredns:v1.11.1
#registry.k8s.io/pause:3.9
#registry.k8s.io/etcd:3.5.10-0
#registry.k8s.io/pause:3.6
#quay.io/tigera/operator:v1.30.4
#docker.io/calico/typha:v3.26.1
#docker.io/calico/cni:v3.26.1
#docker.io/calico/node:v3.26.1
#docker.io/calico/apiserver:v3.26.1
#docker.io/calico/pod2daemon-flexvol:v3.26.1
#docker.io/calico/csi:v3.26.1
#docker.io/calico/node-driver-registrar:v3.26.1
#docker.io/flannel/flannel:v0.24.2
#docker.io/flannel/flannel-cni-plugin:v1.4.0-flannel1
#docker.io/flannel/flannel:v0.24.2
#下载代理镜像
docker pull k8s.dockerproxy.com/kube-apiserver:v1.29.0
docker pull k8s.dockerproxy.com/kube-controller-manager:v1.29.0
docker pull k8s.dockerproxy.com/kube-scheduler:v1.29.0
docker pull k8s.dockerproxy.com/kube-proxy:v1.29.0
docker pull k8s.dockerproxy.com/coredns/coredns:v1.11.1
docker pull k8s.dockerproxy.com/pause:3.9
docker pull k8s.dockerproxy.com/etcd:3.5.10-0
docker pull k8s.dockerproxy.com/pause:3.6
docker pull quay.io/tigera/operator:v1.30.4
docker pull docker.io/calico/typha:v3.26.1
docker pull docker.io/calico/cni:v3.26.1
docker pull docker.io/calico/node:v3.26.1
docker pull docker.io/calico/apiserver:v3.26.1
docker pull docker.io/calico/kube-controllers:v3.26.1
docker pull docker.io/calico/pod2daemon-flexvol:v3.26.1
docker pull docker.io/calico/csi:v3.26.1
docker pull docker.io/calico/node-driver-registrar:v3.26.1
docker pull docker.io/flannel/flannel:v0.24.2
docker pull docker.io/flannel/flannel-cni-plugin:v1.4.0-flannel1
docker pull docker.io/flannel/flannel:v0.24.2
#将代理镜像重命名为原镜像名
docker tag k8s.dockerproxy.com/kube-apiserver:v1.29.0 registry.k8s.io/kube-apiserver:v1.29.0
docker tag k8s.dockerproxy.com/kube-controller-manager:v1.29.0 registry.k8s.io/kube-controller-manager:v1.29.0
docker tag k8s.dockerproxy.com/kube-scheduler:v1.29.0 registry.k8s.io/kube-scheduler:v1.29.0
docker tag k8s.dockerproxy.com/kube-proxy:v1.29.0 registry.k8s.io/kube-proxy:v1.29.0
docker tag k8s.dockerproxy.com/coredns/coredns:v1.11.1 registry.k8s.io/coredns/coredns:v1.11.1
docker tag k8s.dockerproxy.com/pause:3.9 registry.k8s.io/pause:3.9
docker tag k8s.dockerproxy.com/etcd:3.5.10-0 registry.k8s.io/etcd:3.5.10-0
docker tag k8s.dockerproxy.com/pause:3.6 registry.k8s.io/pause:3.6
#删除代理镜像
docker rmi k8s.dockerproxy.com/kube-apiserver:v1.29.0
docker rmi k8s.dockerproxy.com/kube-controller-manager:v1.29.0
docker rmi k8s.dockerproxy.com/kube-scheduler:v1.29.0
docker rmi k8s.dockerproxy.com/kube-proxy:v1.29.0
docker rmi k8s.dockerproxy.com/coredns/coredns:v1.11.1
docker rmi k8s.dockerproxy.com/pause:3.9
docker rmi k8s.dockerproxy.com/etcd:3.5.10-0
docker rmi k8s.dockerproxy.com/pause:3.6
images='
registry.k8s.io/kube-apiserver:v1.29.0
registry.k8s.io/kube-controller-manager:v1.29.0
registry.k8s.io/kube-scheduler:v1.29.0
registry.k8s.io/kube-proxy:v1.29.0
registry.k8s.io/coredns/coredns:v1.11.1
registry.k8s.io/pause:3.9
registry.k8s.io/etcd:3.5.10-0
registry.k8s.io/pause:3.6
quay.io/tigera/operator:v1.30.4
docker.io/calico/typha:v3.26.1
docker.io/calico/cni:v3.26.1
docker.io/calico/node:v3.26.1
docker.io/calico/apiserver:v3.26.1
docker.io/calico/kube-controllers:v3.26.1
docker.io/calico/pod2daemon-flexvol:v3.26.1
docker.io/calico/csi:v3.26.1
docker.io/calico/node-driver-registrar:v3.26.1
docker.io/flannel/flannel:v0.24.2
docker.io/flannel/flannel-cni-plugin:v1.4.0-flannel1
docker.io/flannel/flannel:v0.24.2'
DIR="$(cd "$(dirname "$0")" && pwd)"
docker save -o  $DIR/k8s-1-29-0.tar $images
#docker load -i ./k8s-1-29-0.tar
