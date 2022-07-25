==================
Create Devstack VM
==================

This repository contains two Ansible roles for automating the creation of
VMs that run devstack. Simply run the ``setup_vm.sh`` script with the desired
name of the VM as an argument, like for example ``./setup_vm.sh c9s-debug``.
Then, Ansible will ask you to enter the sudo password for the local host.

.. Note:: Make sure SSHD is running on your local host before running the
    script.

Installation
============

This script should work with ansible 2.12 or newer. To install the roles
it depends on you can run::

    $ ansible-galaxy install -r requirements.yaml

Variables
=========

The following list shows configuration variables and their defaults.

* ds_base_dir: "{{ lookup('env', 'HOME') }}/VM"
* ds_base_img: "CentOS-Stream-GenericCloud-9-20220211.1.x86_64-ResizedOnly.qcow2"
* ds_sync_folders:
    - barbican-tempest-plugin
    - designate-tempest-plugin
    - devstack-helpers
    - octavia
    - octavia-dashboard
    - octavia-lib
    - octavia-tempest-plugin
    - ovn-octavia-provider
    - tempest

``ds_base_dir`` is use as a base directory when creating files on the local
host. The base image configured with ``ds_base_img`` must be store in there.
``ds_sync_folders`` lists the subdirectories of ``~/openstack`` that should be
synced with the VM.

You can overwrite the default value by adding them as key=value arguments
when running the ``setup_vm.sh`` script::

    $ ./setup_vm.sh c9s-debug ds_base_dir=$HOME/devstack ds_base_img=myimage.qcow2

Output of stack.sh
==================

restack.sh may take a long time to finish. By running
``less +F ~/devstack/output.log`` in the VM while Ansible runs the script one
can see the current status. This file is also helpful for debugging in case
the script does not succeed.
