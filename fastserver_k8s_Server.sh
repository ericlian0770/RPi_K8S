sudo apt-get install -y python-gevent python-gevent-websocket
sudo apt-get install -y python-gevent 
sudo apt-get install -y python-opencv 
sudo apt-get install -y libjasper1 
sudo apt-get install -y libqtgui4 
sudo apt-get install -y libqt4-test 
sudo apt-get install -y libcblas-dev 
sudo apt-get install -y libhdf5-dev 
sudo apt-get install -y libcblas-dev
sudo apt-get install -y libhdf5-dev
sudo apt-get install -y libcblas-dev
sudo apt-get install -y libhdf5-dev
sudo apt-get install -y libhdf5-serial-dev
sudo apt-get install -y libatlas-base-dev
sudo apt-get install -y libcblas-dev
sudo apt-get install -y libhdf5-dev
sudo apt-get install -y libhdf5-serial-dev
sudo apt-get install -y libatlas-base-dev
sudo apt-get install -y libjasper-dev
sudo apt-get install -y install net-tools
apt-get update && apt-get install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
cat <<EOF >/etc/apt/sources.list.d/kubernetes.list
deb http://apt.kubernetes.io/ kubernetes-xenial main
EOF
apt-get update
apt-get install -y docker.io
apt-get install -y kubelet kubeadm kubectl kubernetes-cni
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo apt-get install -y linux-libc-dev golang gcc
sudo apt-get install -y mingw-w64
sudo apt-get install     apt-transport-https     ca-certificates     curl     gnupg     lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo   "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
mkdir -p ~/.local/bin/kubectl
mv ./kubectl ~/.local/bin/kubectl
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl
sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubectl
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
systemctl enable docker.service
systemctl enable containerd.service
apt install -y ipvsadm
sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io
snap install kubectl --classic
snap install kubeadm --classic
snap install kubelet --classic
sudo snap install microk8s --classic --channel=1.21
sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube
su - $USER
microk8s.stop

cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
br_netfilter
EOF

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sudo sysctl --system


kubectl version --client
swapoff -a
sed -i 's/.*swap.*/#&/' /etc/fstab
kubeadm init --pod-network-cidr=10.244.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=/etc/kubernetes/admin.conf

apt-get install -y jq
snap install --channel=2.9/stable maas
git clone https://github.com/InfraBuilder/k8s-bench-suite.git

kubectl label node raspberrypi node-role.kubernetes.io/worker=worker
kubectl label node raspberrypi node-role.kubernetes.io/slave=slave
kubectl label node raspberrypi2 node-role.kubernetes.io/worker=worker
kubectl label node raspberrypi2 node-role.kubernetes.io/slave=slave

sudo apt-get install qemu-user-static
kubeadm init --pod-network-cidr=192.168.0.0/16

kubectl get pods --all-namespaces -o wide

mkdir /run/systemd/resolve/
scp /run/systemd/resolve/resolv.conf root@10.10.10.10:/run/systemd/resolve/resolv.conf