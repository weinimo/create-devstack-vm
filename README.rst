==================
Create Devstack VM
==================

This repository contains two Ansible playbooks for automating the creation of
VMs that run devstack. Simply run the ``setup_vm.sh`` script with the desired
name of the VM as an argument, like for example ``./setup_vm.sh c9s-debug``.
Then, Ansible will ask you to enter the sudo password for the local host.

.. Note:: Make sure SSHD is running on your local host before running the
    script.

Variables
=========

The following list shows configuration variables and their defaults.

* ds_base_dir: "{{ lookup('env', 'HOME') }}/VM"
* ds_base_img: "CentOS-Stream-GenericCloud-9-20220211.1.x86_64-ResizedOnly.qcow2"

``ds_base_dir`` is use as a base directory when creating files on the local
host. The base image configured with ``ds_base_img`` must be store in there.

TODO
====

* Automatic resize of qcow2 image
