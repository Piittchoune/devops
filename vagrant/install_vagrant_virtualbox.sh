#!/bin/bash

# Prerequisite

# Installation #
echo "Installation of Vagrant Virtualbox"
echo "-------------------------------"

sudo dnf -y install wget

sudo wget -P /etc/yum.repos.d/ https://download.virtualbox.org/virtualbox/rpm/fedora/virtualbox.repo
sudo dnf search virtualbox -y
sudo dnf install -y gcc binutils make glibc-devel patch libgomp glibc-headers  kernel-headers kernel-devel-`uname -r` dkms
sudo dnf install VirtualBox-7.0

sudo usermod -a -G vboxusers ${USER}

sudo /usr/lib/virtualbox/vboxdrv.sh setup

sudo dnf -y install vagrant

echo "-------------------------------"
echo "[OK] - Installation of Vagrant Virtualbox"

# Initial Project Creation # 
echo "Testing the Vagrant Virtualbox installation"
echo "-------------------------------"

vagrant init fedora/38-cloud-base
vagrant up
vagrant status
result=$?
if [ $result -eq 0 ] ; then 
    echo "-------------------------------"
    echo "[OK] - Testing the Vagrant Virtualbox installation"
    vagrant destroy -f
    rm -rf Vagrantfile .vagrant/
    echo "Vagrant Virtualbox was successfuly installed, enjoy!"
    exit 0
else
    echo "-------------------------------"
    echo "[ERROR] - Testing the Vagrant Virtualbox installation"
    vagrant destroy -f
    rm -rf Vagrantfile .vagrant/
    echo "Error during the Vagrant Virtualbox Installation"
    exit 1
fi
