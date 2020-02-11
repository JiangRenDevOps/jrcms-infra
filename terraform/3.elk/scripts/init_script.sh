#!/bin/bash
set -e

apt update

apt install -y ansible

ansible-galaxy install geerlingguy.docker
ansible-galaxy install geerlingguy.pip

git clone https://github.com/davisliu11/jrcms-infra.git /jrcms-infra

ln -s /jrcms-infra/terraform/3.elk/scripts/ /scripts

env
echo "DDDDDDDDDDDDDDDD"
ln -s /scripts/site.yaml /site.yaml

echo "EEEEEEEEEEEE"
ansible-playbook /site.yaml

echo "FFFFFFFFFFF"
cp /scripts/site.yaml /site.yaml
ansible-playbook /site.yaml

