#!/bin/bash
DIR="$(cd "$(dirname "$0")" && pwd)/../"
source $DIR/cqsw-paas-config.sh
##The Node of Master in Kubernetes is initing
kubeadm init \
--apiserver-advertise-address $Master_IP \
--cri-socket unix:///var/run/cri-dockerd.sock \
--image-repository $Harbor_IP/library \
--kubernetes-version 1.29.0 \
--pod-network-cidr $Pod_Network_CIDR \
--service-cidr $Service_CIDR

##The Node of Master in Kubernetes is configruating
if systemctl is-active kubelet.service; then  
	    mkdir -p $HOME/.kube
	    sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
	    sudo chown $(id -u):$(id -g) $HOME/.kube/config  
	    kubeadm token create cqswxy.cqswcloudcompute --certificate-key /etc/kubernetes/pki/ca.crt --print-join-command --ttl 0
	    Ca_Cert_Hash=$(openssl x509 -pubkey -in /etc/kubernetes/pki/ca.crt | openssl rsa -pubin -outform der 2>/dev/null | openssl dgst -sha256 -hex | sed 's/^.* //')
	    sed -i "s/Discovery_token_ca_cert_HASH=.*/Discovery_token_ca_cert_HASH=$Ca_Cert_Hash/" $DIR/cqsw-paas-config.sh
	    scp $DIR/cqsw-paas-config.sh $Node_NAME:$DIR/cqsw-paas-config.sh
    else  
	    echo "Failed to init the node of Msater in kubernetes"  
fi

