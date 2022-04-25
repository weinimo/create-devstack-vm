#!/bin/sh

set -ex

cd $HOME/devstack/

./unstack.sh || true

./clean.sh || true

sudo rm -f /opt/stack/horizon/openstack_dashboard/__pycache__/__init__.cpython-36.pyc /opt/stack/horizon/openstack_dashboard/__pycache__/hooks.cpython-36.pyc

sudo rm -rf /var/run/openvswitch /var/run/ovn

./stack.sh 2>&1 | tee output.log

cd /opt/stack/tempest && tox -evenv-tempest -- pip \
	    install -e /opt/stack/octavia-tempest-plugin
/opt/stack/tempest/.tox/tempest/bin/pip install -q pylint autopep8
