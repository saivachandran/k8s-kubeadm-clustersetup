#!/bin/bash

apt update -y

apt dist-upgrade -y

timedatectl set-timezone Asia/Kolkata

hostnamectl set-hostname k8s-master

# Step1) Disable Swap (Run it on MASTER & WORKER Nodes)

swapoff -a
sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

# 1a) Bridge Traffic

lsmod | grep br_netfilter
sudo modprobe br_netfilter$ cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

#Step2) Install Docker (Run it on MASTER & WORKER Nodes)

apt-get update -y
apt install docker.io -y
systemctl start docker

# 2a) Setting up the Docker daemon

cat <<EOF | sudo tee /etc/docker/daemon.json
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

# Reload, enable and restart the docker service

systemctl daemon-reload
systemctl enable docker
systemctl restart docker

# Step3) Install kubeadm, kubelet, and kubectl (Run it on MASTER & WORKER Nodes)

apt-get update && sudo apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
cat <<EOF | sudo tee /etc/apt/sources.list.d/kubernetes.list
deb https://apt.kubernetes.io/ kubernetes-xenial main
EOF

# 3a) Installing Kubeadm, Kubelet, Kubectl:

apt-get update -y
apt-get install -y kubelet kubeadm kubectl
apt-mark hold kubelet kubeadm kubectl

# 3b) Start and enable Kubelet

systemctl daemon-reload
systemctl enable kubelet
systemctl restart kubelet

