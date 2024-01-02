#!/bin/bash

# Removing #
echo "Removing Vagrant Libvirt"
echo "-------------------------------"
sudo dnf remove vagrant qemu libvirt -y
vagrant -h 1> /dev/null 2> /dev/null

result=$?
if [ $result -eq 0 ] ; then 
    echo "-------------------------------"
    echo "[ERROR] - Issue occure while removing Vagrant Libvirt"
    exit 1
else
    echo "-------------------------------"
    echo "[OK] - Removing Vagrant Libvirt"
    exit 0
fi
