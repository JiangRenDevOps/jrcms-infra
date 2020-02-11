#!/bin/bash
set -e

apt update

apt install -y ansible

ansible-galaxy install geerlingguy.docker
ansible-galaxy install geerlingguy.pip
ansible-galaxy install geerlingguy.filebeat

ansible_playbook=/site.yaml
wget https://raw.githubusercontent.com/github.com/davisliu11/jrcms-infra/terraform/4.app/scripts/site.yaml -O $ansible_playbook

sed -i 's/ELK_IP/ELK_IP_PLACEHOLDER/g' site.yaml

ansible-playbook $ansible_playbook
