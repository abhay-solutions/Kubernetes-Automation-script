#!/bin/bash

#set -e

#Changing user to root from user for access
#sudo -i

#Here Downloading Helm by using curl commad
sudo curl https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh

#Providing change mode access to shell file
sudo chmod 700 get_helm.sh

#Running shell script
sudo ./get_helm.sh

#Creating Service Account,Creating cluster role binding, Path Deploy and Initializing Helm
sudo kubectl create serviceaccount --namespace kube-system tiller
sudo kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller
sudo kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'
sudo helm init --service-account tiller --upgrade
