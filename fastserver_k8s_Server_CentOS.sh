yum install -y kernel-devel
yum install -y kernel-headers
yum install -y kernel-PAE-devel
yum install -y kernel-syms
yum groupinstall -y "Development Tools"
yum update
yum install -y glibc.i686 
yum install -y kernel-devel 
yum install -y asciidoc audit-libs-devel bash bc binutils binutils-devel bis on diffutils elfutils
yum install -y elfutils-devel elfutils-libelf-devel findutils flex gawk gccgettext gzip hmaccalc hostname java-devel
yyum install -y asciidoc audit-libs-devel bash bc binutils binutils-devel bi son diffutils elfutils
yum install -y elfutils-devel elfutils-libelf-devel findutils flex gawk gccgettext gzip hmaccalc hostname java-devel
yum install -y m4 make module-init-tools ncurses-devel net-tools newt-develnumactl-devel openssl 
yum install -y asciidoc audit-libs-devel bash bc binutils binutils-devel bis on diffutils elfutils
yum install -y elfutils-devel elfutils-libelf-devel findutils flex gawk gccgettext gzip hmaccalc hostname java-devel
yum install -y m4 make module-init-tools ncurses-devel net-tools newt-develnumactl-devel openssl 
yum install -y patch pciutils-devel perl perl-ExtUtils-Embed pesign python-d evel python-docutils redhat-rpm-config 
yum install -y asciidoc audit-libs-devel bash bc binutils binutils-devel bis on diffutils elfutils
yum install -y elfutils-devel elfutils-libelf-devel findutils flex gawk gccgettext gzip hmaccalc hostname java-devel
yum install -y m4 make module-init-tools ncurses-devel net-tools newt-develnumactl-devel openssl 
yum install -y patch pciutils-devel perl perl-ExtUtils-Embed pesign python-d evel python-docutils redhat-rpm-config 
yum install -y rpm-build sh-utils tar xmlto xz zlib-devel
yum install -y asciidoc audit-libs-devel bash bc binutils binutils-devel bis on diffutils elfutils
yum install -y elfutils-devel elfutils-libelf-devel findutils flex gawk gccgettext gzip hmaccalc hostname java-devel
yum install -y m4 make module-init-tools ncurses-devel net-tools newt-develnumactl-devel openssl 
yum install -y patch pciutils-devel perl perl-ExtUtils-Embed pesign python-d evel python-docutils redhat-rpm-config 
yum install -y rpm-build sh-utils tar xmlto xz zlib-devel
yum install -y patch pciutils-devel perl perl-ExtUtils-Embed pesign python-d evel python-docutils redhat-rpm-config 
yum install -y kernel-headers 
yum install -y kernel-PAE-devel 
yum install -y kernel-syms 
yum install -y kernel-devel 
yum install -y kernel-headers 
yum install -y kernel-PAE-devel 
yum install -y kernel-syms 
yum groupinstall -y "Development Tools" 
yum install -y kernel kernel-devel
yum install -y gcc* 
yum update
yum install -y python3-devel
yum install -y python-devel
yum install -y libevent-devel
yum install -y openssl-devel
yum install -y libffi-devel
yum install -y libffi-devel
yum install -y bzip2-devel 
yum install -y python-pip
yum install -y python3-pip

curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh

systemctl enable docker.service
systemctl enable containerd.service

cat <<EOF | sudo tee /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
exclude=kubelet kubeadm kubectl
EOF

sudo setenforce 0
sudo sed -i 's/^SELINUX=enforcing$/SELINUX=permissive/' /etc/selinux/config

sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
yum install -y kernel-headers golang gcc

sudo systemctl enable --now kubelet

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-latest.x86_64.rpm
sudo rpm -ivh minikube-latest.x86_64.rpm

sed -i 's/cgroup-driver=systemd/cgroup-driver=cgroupfs/g' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf
systemctl daemon-reload
systemctl restart kubelet

git clone https://github.com/InfraBuilder/k8s-bench-suite.git
git clone https://github.com/aquasecurity/kube-bench

kubectl taint nodes --all node-role.kubernetes.io/master-
kubectl label node raspberrypi node-role.kubernetes.io/worker=worker
kubectl label node raspberrypi node-role.kubernetes.io/slave=slave
kubectl label node raspberrypi2 node-role.kubernetes.io/worker=worker
kubectl label node raspberrypi2 node-role.kubernetes.io/slave=slave
kubectl version --client

swapoff -a
sed -i 's/.*swap.*/#&/' /etc/fstab
kubeadm init --pod-network-cidr=10.244.0.0/16

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config
export KUBECONFIG=/etc/kubernetes/admin.conf

kubectl describe nodes

kubectl apply -f https://github.com/coreos/flannel/raw/master/Documentation/kube-flannel.yml

kubectl api-resources

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0/aio/deploy/recommended.yaml

kubeadm init --pod-network-cidr=192.168.0.0/16

kubectl get pods --all-namespaces -o wide

mkdir /run/systemd/resolve/
scp /run/systemd/resolve/resolv.conf root@10.10.10.10:/run/systemd/resolve/resolv.conf