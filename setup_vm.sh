#!/usr/bin/env bash
# Creates a new VM and sets up devstack on it
# Provide the new host name as first argument

ansible-playbook -i hosts -K -D -e ds_hostname=$1 make_vm.yaml || exit 1
ansible-playbook -i hosts -D -l $1 setup_devstack.yaml
