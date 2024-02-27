# CQSW-Paas-Online

CQSW-Paas-Online是一个利用shell脚本帮助用户安装Docker以及部署K8S集群，用户只需要根据自己的实际情况填写cqsw-paas-config.sh，依次执行安装脚本即可完成部署。
##注意！
- 适用主机：Ubuntu22.04.2
- 每台机器 2 GB 以上的内存，内存不足时应用会受限制。
- 用作控制平面节点的计算机上至少有 2 个 CPU。
- 集群中所有计算机之间具有完全的网络连接。

```
CQSW-Paas-Online
├── base-env-setup.sh ##部署基本环境（直接执行）
├── cqsw-paas-config.sh ##用户根据实际情况填写（填写内容）
├── docker
│   ├── cri-dockerd_0.3.4.3-0.ubuntu-focal_amd64.deb ##cri-dockerd
│   ├── Docker-install.sh ##部署设置Docker和部署cri-dockerd（直接执行）
│   ├── Harbor-config.sh  ##设置Docker Harbor，完成部署后才可执行（直接执行）
│   ├── Harbor-install.sh ##部署Docker Harbor（直接执行）
│   ├── harbor-offline-installer-v2.10.0.tgz ##Docker Harbor离线压缩包
│   ├── images-pull.sh ##下载K8S所需要的镜像（直接执行）
│   └── images-tag-push.sh ##推送K8S镜像到Docker Harbor仓库中（直接执行）
└── kubernetes
    ├── calico ##Calico是一个用于容器、虚拟机和基于本地主机的工作负载的开源网络和网络安全解决方案
    │   ├── custom-resources.yaml 
    │   └── tigera-operator.yaml
    ├── Calico-create.sh ##部署Calico （直接执行）
    ├── Flannel  ##Flannel是CoreOS团队开发的一个网络插件，用于为Kubernetes集群提供网络功能。
    │   └── kube-flannel.yml
    ├── K8S-install.sh  ##安装K8S的基础环境（直接执行）
    ├── Master-init.sh  ##初始化Master节点（直接执行）
    ├── Master-reset.sh ##重新设置（格式化）K8S节点（直接执行）
    ├── Monitor ##监控Docker容器、K8S的Pod
    │   ├── k8s-scope.yaml
    │   └── Monitor-install.sh ##部署weavescope监控 （直接执行）
    ├── Node-join.sh ##将node节点加入到K8S集群中
    └── simple-pod.yaml ##测试pod
```

