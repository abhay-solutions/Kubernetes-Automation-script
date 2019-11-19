#!/bin/bash
echo " K8s Node Installation Started "  
sudo apt-get update
echo " Docker installation Started "  
sudo apt-get install -y docker.io
echo " Docker installation Done" 
echo " Curl installation Started "  
sudo apt-get install -y curl
echo " Curl installation Done Successfully "  echo " Checking Packages "  
sudo curl -s https://packages.cloud.google.com/apt/dists/kubernetes-xenial/main/binary-amd64/Packages | grep Version | awk '{print $2}'
echo " Removing Locks "  
sudo rm /var/lib/apt/lists/lock
sudo rm /var/cache/apt/archives/lock
sudo rm /var/lib/dpkg/lock
echo " Locks Removed Successfully "  
echo " Applying Swapoff "  
sudo sed -i.bak '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab
sudo swapoff -a
echo " Installation of K8s Started "  
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
sudo curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add - && \
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list && \
sudo apt-get update -q && \
sudo apt-get install -qy kubelet kubectl kubeadm
echo " Installation of K8s Successfully Done "  
echo " Checking Versions "  
echo " Version of KUBEADM- "  
sudo kubeadm version
echo " Version of KUBECTL- "  
sudo kubectl version
echo " Version of KUBELET- "  
sudo kubelet --version
echo " Applying Hold "  
sudo apt-mark hold kubelet kubeadm kubectl
echo " K8S Node Setup is Done Successfully "  
echo " Joining Node to Kubemaster " 
#enter the kubernetes join command 
echo " Node Joined to Master Successfully " 
echo "Setting up Insecure Registry"
sudo cat > /etc/docker/daemon.json << EOF
{
 "insecure-registries": [
   "ip-address"
 ],
 "disable-legacy-registry": true
}
EOF
echo "Updated values in daemon.json"
echo "Restarting Docker"
sudo systemctl restart docker
echo "Docker restarted successfully"
echo "Login into Insecure registry"
sudo docker login -u username -p password ip-address
echo "Successfully logged into Docker registry" 