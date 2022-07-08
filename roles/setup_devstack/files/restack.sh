#!/bin/bash
set -ex
set -o pipefail

cd $HOME/devstack/

./unstack.sh || true
./clean.sh || true
sudo rm -f /opt/stack/horizon/openstack_dashboard/__pycache__/__init__.cpython-36.pyc /opt/stack/horizon/openstack_dashboard/__pycache__/hooks.cpython-36.pyc
sudo rm -rf /var/run/openvswitch /var/run/ovn

./stack.sh 2>&1 | tee output.log

mysql -uroot -e "CREATE USER 'osdebug'@'localhost' IDENTIFIED BY 'password'; \
    GRANT ALL PRIVILEGES ON *.* TO 'osdebug'@'localhost' WITH GRANT OPTION; \
    FLUSH PRIVILEGES;"
cd /opt/stack/tempest && tox -evenv-tempest -- pip \
    install -q -e /opt/stack/octavia-tempest-plugin
/opt/stack/tempest/.tox/tempest/bin/pip install -q pylint autopep8
