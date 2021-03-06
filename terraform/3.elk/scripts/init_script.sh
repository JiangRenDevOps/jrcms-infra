#!/bin/bash
set -e

apt update

apt install -y ansible

ansible-galaxy install geerlingguy.docker
ansible-galaxy install geerlingguy.pip

git clone https://github.com/davisliu11/jrcms-infra.git /jrcms-infra

ln -s /jrcms-infra/terraform/3.elk/scripts/ /scripts
ln -s /scripts/site.yaml /site.yaml

sudo ansible-playbook /site.yaml
