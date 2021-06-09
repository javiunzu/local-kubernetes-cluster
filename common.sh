set -eu
export LANGUAGE=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export DEBIAN_FRONTEND=noninteractive
locale-gen en_US.UTF-8
dpkg-reconfigure locales
# The xenial repository still contains the latest version of kubernetes.
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"
apt update
apt install -y ntp jq
systemctl enable ntp
systemctl start ntp
apt install -y docker.io
apt install -y kubelet kubeadm kubectl kubernetes-cni
swapoff -a
sed -i '/swap/d' /etc/fstab

systemctl enable docker && systemctl start docker
systemctl enable kubelet && systemctl start kubelet
