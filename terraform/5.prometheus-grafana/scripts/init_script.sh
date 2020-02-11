#!/bin/bash
set -e

apt update

apt install -y ansible

ansible-galaxy install geerlingguy.docker
ansible-galaxy install geerlingguy.pip

git clone https://github.com/davisliu11/jrcms-infra.git /jrcms-infra

ln -s /jrcms-infra/terraform/5.prometheus-grafana/scripts /scripts

ln -s /scripts/site.yaml /site.yaml

PROMETHEUS_CONFIG=/scripts/docker-compose/config/prometheus/prometheus.yml
sed -i 's/APP_IP/APP_IP_PLACEHOLDER/g' $PROMETHEUS_CONFIG

ansible-playbook /site.yaml
