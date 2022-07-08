#!/usr/bin/env bash
# Creates a new VM and sets up devstack on it
# Provide the new host name as first argument
# Additional variable definitions can be added in following arguments.
# Use the form key=value.
set -ex

ds_hostname="$1"
ansible_opts="-e ds_hostname=$ds_hostname "
shift

while [ "$1" ]
do
  ansible_opts+="-e $1 "
  shift
done

ansible-playbook -i hosts -K -D $ansible_opts make_vm.yaml
ansible-playbook -i hosts -D -l $ds_hostname setup_devstack.yaml
