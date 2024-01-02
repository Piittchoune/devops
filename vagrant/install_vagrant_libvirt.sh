#!/bin/bash

# Prerequisite
# check os family
# check if cpu can do virt
# Installation #
echo "Installation of Vagrant Libvirt"
echo "-------------------------------"
# case os = rhel like
sudo dnf remove vagrant-libvirt
sudo sed -i \
    '/^\(exclude=.*\)/ {/vagrant-libvirt/! s//\1 vagrant-libvirt/;:a;n;ba;q}; $aexclude=vagrant-libvirt' \
    /etc/dnf/dnf.conf
# shellcheck disable=SC2207
vagrant_libvirt_deps=($(sudo dnf repoquery --disableexcludes main --depends vagrant-libvirt 2>/dev/null | cut -d' ' -f1))
# shellcheck disable=SC2068
dependencies=$(sudo dnf repoquery --qf "%{name}" ${vagrant_libvirt_deps[@]/#/--whatprovides })
# shellcheck disable=SC2086
sudo dnf install --assumeyes @virtualization ${dependencies}

vagrant plugin install vagrant-libvirt
#
sudo usermod -a -G libvirt $USER
sudo systemctl enable --now libvirtd
echo "-------------------------------"
echo "[OK] - Installation of Vagrant Libvirt"

# Initial Project Creation # 
echo "Testing the Vagrant Libvirt installation"
echo "-------------------------------"

vagrant init fedora/38-cloud-base
vagrant up --provider=libvirt
vagrant status
result=$?
if [ $result -eq 0 ] ; then 
    echo "-------------------------------"
    echo "[OK] - Testing the Vagrant Libvirt installation"
    vagrant destroy -f
    rm -rf Vagrantfile .vagrant/
    echo "Vagrant Libvirt was successfuly installed, enjoy!"
    exit 0
else
    echo "-------------------------------"
    echo "[ERROR] - Testing the Vagrant Libvirt installation"
    vagrant destroy -f
    rm -rf Vagrantfile .vagrant/
    echo "Error during the Vagrant Libvirt Installation"
    exit 1
fi
