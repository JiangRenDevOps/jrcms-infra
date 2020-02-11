#!/bin/bash
set -e

apt update

apt install -y ansible

ansible-galaxy install geerlingguy.docker
ansible-galaxy install geerlingguy.pip
ansible-galaxy install geerlingguy.filebeat

git clone https://github.com/davisliu11/jrcms-infra.git /jrcms-infra

ln -s /jrcms-infra/terraform/4.app/scripts/ /scripts

ln -s /scripts/site.yaml /site.yaml

sudo ansible-playbook /site.yaml

sed -i 's/ELK_IP/ELK_IP_PLACEHOLDER/g' $ANSIBLE_PLAYBOOK
