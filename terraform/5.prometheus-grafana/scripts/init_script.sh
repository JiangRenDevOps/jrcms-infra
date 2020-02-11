#!/bin/bash
set -e

apt update

apt install -y ansible

ansible-galaxy install geerlingguy.docker
ansible-galaxy install geerlingguy.pip

git clone https://github.com/davisliu11/jrcms-infra.git /jrcms-infra

SCRIPTS=/jrcms-infra/terraform/5.prometheus-grafana/scripts/
ln -s $SCRIPTS /scripts

ANSIBLE_PLAYBOOK=$SCRIPTS/site.yaml
ansible-playbook $ANSIBLE_PLAYBOOK

PROMETHEUS_CONFIG=$SCRIPTS/docker-compose/config/prometheus/prometheus.yml
sed -i 's/APP_IP/APP_IP_PLACEHOLDER/g' $PROMETHEUS_CONFIG