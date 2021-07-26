#!/bin/bash

set -xv

#install and upgrade
pip3 install --upgrade pip
pip3 install --upgrade awscli

#var
docker= which docker && docker --version
terraform= which terraform && terraform --version
ansible= which ansible && ansible --version
GREEN=
RESET='\033[0m'

#-----------Docker install
if [ "$docker" != 0 ]; then
   echo -e '\033[0;32m'docker already installed
else
   sudo yum -y update
   sudo yum install -y yum-utils device-mapper-persistent-data lvm2
   sudo yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
   sudo dnf install -y https://download.docker.com/linux/centos/7/x86_64/stable/Packages/containerd.io-1.2.6-3.3.el7.x86_64.rpm
   sudo yum install -y docker-ce docker-ce-cli containerd.io --nobest
   sudo systemctl start docker && sudo systemctl enable docker
   echo -e '\033[0;32m'docker installation completed
fi


#-----------Terraform install
if [ "$terraform" != 0 ]; then
   echo -e '\033[0;32m'Terraform already installed
else
   sudo curl -O https://releases.hashicorp.com/terraform/0.12.24/terraform_0.12.24_linux_amd64.zip
   sudo yum install -y unzip
   sudo unzip terraform_0.12.24_linux_amd64.zip -d /usr/local/bin/
   echo -e '\033[0;32m'Terraform installation completed
fi

#---------Ansible install

if [ "$ansible" != 0 ]; then
   echo -e '\033[0;32m'Ansible already installed
else
   sudo yum install -y wget
   sudo wget https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm
   sudo rpm -ivh epel-release-latest-8.noarch.rpm
   sudo yum --enablerepo=epel install -y ansible
   echo -e '\033[0;32m'Ansible installation completed
fi

#-----------User Permissions
   sudo usermod -aG docker ec2-user
   # command
exit