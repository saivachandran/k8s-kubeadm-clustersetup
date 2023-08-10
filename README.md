# kubernetes-package-installation.md

1. Update the apt package index and install packages needed to use the Kubernetes apt repository
   ```
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl
   ```

 2. Download the Google Cloud public signing key:

       ```
       curl -fsSL https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-archive-keyring.gpg
       ```
3. Add the Kubernetes apt repository:

```
    echo "deb [signed-by=/etc/apt/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee     /etc/apt/sources.list.d/kubernetes.list
```
4. Update apt package index, install kubelet, kubeadm and kubectl, and pin their version:
```
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
```

[Rfer1](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)


# k8s-cluster setup url using kubeadm

[cluster-setup](https://bikramat.medium.com/set-up-a-kubernetes-cluster-with-kubeadm-508db74028ce)


# bring node ready state apply weaveworks network
```
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

```

       
