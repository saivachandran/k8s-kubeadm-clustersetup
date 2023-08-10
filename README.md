
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




after cluster-setup.sh completion forllow below steps make nodes ready state

bring node ready state apply weaveworks network
```
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml

```

step: 1 - on master node as a root user

   ```
    kubeadm init --pod-network-cidr 10.0.0.0/16
   ```

step 2 - it will give config and agent token like below "token has to change in your's"

```
Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 172.31.6.184:6443 --token tv65a3.ipbr83iy82fbjsbj \
	--discovery-token-ca-cert-hash sha256:d88e7625a4b1c923b500693d2303c893df80156d42f8ec318c12464aa446acaa 

'''

step 3 - on master run below as a normal user

```
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config
```

# verify nodes on master as a normal user

```
kubectl get nodes
'''

step 4 - on worker node as a root user Note: token has to change wit yours

```
kubeadm join 172.31.6.184:6443 --token tv65a3.ipbr83iy82fbjsbj \
	--discovery-token-ca-cert-hash sha256:d88e7625a4b1c923b500693d2303c893df80156d42f8ec318c12464aa446acaa
```







    

       
