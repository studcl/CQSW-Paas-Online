#!/bin/bash
ping -c 4 www.baidu.com > /dev/null
if [ $? -ne 0 ]; then
	systemctl enable NetworkManager
	systemctl restart NetworkManager
	echo "Failed to install,Please check Network"
	exit
else
sudo apt-get install ca-certificates curl gnupg -y
sudo install -m 0755-d /etc/apt/keyrings 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg |sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg 
sudo chmod a+r /etc/apt/keyrings/docker.gpg
##Add Docker apt source
echo \
	"deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
	  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" |\
	   sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
##Install Docker
sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-compose
##Docker config 
systemctl enable docker
cat > /etc/docker/daemon.json << EOF
{
  "registry-mirrors": ["https://dockerproxy.com"],
  "exec-opts": ["native.cgroupdriver=systemd"]
}
EOF
systemctl daemon-reload
systemctl restart docker
##Containerd config
containerd config default > /etc/containerd/config.toml
sed -i 's/SystemdCgroup = false/SystemdCgroup = true/' /etc/containerd/config.toml
systemctl enable containerd
systemctl restart containerd
##Install CRI-Dockerd
DIR="$(cd "$(dirname "$0")" && pwd)"
dpkg -i $DIR/cri-dockerd_0.3.4.3-0.ubuntu-focal_amd64.deb
systemctl enable cri-docker
systemctl restart cri-docker
fi
