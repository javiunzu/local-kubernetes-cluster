#!/usr/bin/env bash
set -eu

hostnamectl set-hostname host0
kubeadm init \
 --token ${CLUSTER_TOKEN} \
 --apiserver-advertise-address ${IP_ADDRESS} \
 --apiserver-bind-port 8001 --pod-network-cidr=10.244.0.0/16

export KUBECONFIG="/etc/kubernetes/admin.conf" # Otherwise kubectl won't work.

kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/k8s-manifests/kube-flannel-rbac.yml
cp /etc/kubernetes/admin.conf /vagrant
echo -n "${CLUSTER_TOKEN}" > /vagrant/.cluster_token