#!/usr/bin/env bash

# Optimized dependency installation: de-duplicated package lists and batched installs.
APT_PACKAGES=(
  freeipmi
  i2c-tools
  ipmitool
  libatlas-base-dev
  libcblas-dev
  libhdf5-dev
  libhdf5-serial-dev
  libjasper-dev
  libjasper1
  libqt4-test
  libqtgui4
  openipmi
  python-gevent
  python-gevent-websocket
  python-opencv
  python-pip
  python3-pip
)

PYTHON_PACKAGES=(
  backports-abc
  backports.functools-lru-cache
  backports.shutil-get-terminal-size
  backports.ssl-match-hostname
  BeautifulSoup
  beautifulsoup4
  blivet
  boto3
  botocore
  Brlapi
  certifi
  cffi
  chardet
  click
  clufter
  configobj
  configparser
  configshell-fb
  contextlib2
  coverage
  cryptography
  cupshelpers
  custodia
  decorator
  defusedxml
  di
  Django
  dnspython
  docutils
  entrypoints
  enum34
  ethtool
  filetype
  firstboot
  Flask
  fros
  funcsigs
  future
  futures
  gevent
  greenlet
  gssapi
  idna
  importlib-metadata
  importlib-resources
  iniparse
  initial-setup
  intel-openmp
  ipaclient
  ipaddr
  ipaddress
  ipalib
  ipaplatform
  ipapython
  ipaserver
  IPy
  ipykernel
  ipython
  ipython-genutils
  isc
  iso8601
  isodate
  itsdangerous
  javapackages
  Jinja2
  jmespath
  jupyter-client
  jupyter-core
  jwcrypto
  kdcproxy
  keyring
  kitchen
  kmod
  langtable
  lxml
  m2r
  MarkupSafe
  mercurial
  mistune
  mock
  msrest
  msrestazure
  netaddr
  netifaces
  nodeenv
  nose
  ntplib
  numpy
  oauthlib
  opencv-python
  pandas
  pathlib2
  pcs
  perf
  pexpect
  picamera
  pickleshare
  Pillow
  pip
  pip3
  ply
  policycoreutils-default-encoding
  prompt-toolkit
  ptyprocess
  py
  pyasn1
  pyasn1-modules
  pycparser
  pycups
  pycurl
  Pygments
  pygobject
  pygpgme
  pyinotify
  PyJWT
  pykickstart
  pyliblzma
  pyOpenSSL
  pyparsing
  pyparted
  pysmbc
  python-augeas
  python-dateutil
  python-ldap
  python-linux-procfs
  python-meh
  python-nss
  python-yubico
  pytz
  pyudev
  pyusb
  pyxattr
  PyYAML
  pyzmq
  qrcode
  qtconsole
  QtPy
  redis
  requests
  requests-oauthlib
  RPi.GPIO
  rtslib-fb
  ruamel.ordereddict
  ruamel.yaml
  ruamel.yaml.clib
  s3transfer
  scandir
  schedutils
  SecretStorage
  seobject
  sepolicy
  serial
  setroubleshoot
  setuptools
  simplegeneric
  singledispatch
  six
  slip
  slip.dbus
  soupsieve
  SSSDConfig
  stevedore
  subp
  subprocess32
  suds
  ta
  targetcli-fb
  torch
  tornado
  traitlets
  typing
  uamqp
  urlgrabber
  urllib3
  urwid
  virtualenv
  virtualenv-clone
  virtualenvwrapper
  wcwidth
  webencodings
  Werkzeug
  wheel
  yum-langpacks
  yum-metadata-parser
  zipp
  zope.event
  zope.interface
)

sudo apt-get update
sudo apt-get install -y "${APT_PACKAGES[@]}"

pip install "${PYTHON_PACKAGES[@]}"
pip3 install "${PYTHON_PACKAGES[@]}"

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

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" \ >> /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update && sudo apt-get install -y apt-transport-https curl
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt-get update
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl
sudo apt-get install -y linux-libc-dev golang gcc
sudo apt-get install -y mingw-w64

sudo sed -i 's/ rootwait$/ rootwait cgroup_enable=cpuset cgroup_enable=memory/g' /boot/cmdline.txt #need reboot

swapoff -a
kubeadm init

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

export KUBECONFIG=/etc/kubernetes/admin.conf


hostnamectl set-hostname raspberrypi2
