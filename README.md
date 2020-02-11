# Description

This is the terraform project to create JRCMS infrastructure.

# Pre-requisite

1. use `aws configure` to configure your AWS credential
If you haven't configure, please configure it.

2. make sure you have `id_rsa.pub` file in your `~/.ssh` folder
You should be able to list the below file. 
```
ls ~/.ssh/id_rsa.pub
```
If not, please create the key by `ssh-keygen`.

# To batch execute

execute `./setup_all.sh`

# To batch destroy

execute `./cleanup_all.sh` and remove the s3 bucket: s3-terraform-state-storage-* 

# Folder Structure

## 1.s3-state

This terraform project creates a S3 bucket to store terraform states.

## 2.global

Global AWS resources that should be created only once-off.
- vpc
- s3 to store Terraform state
- security group

## 3.elk

ELK infrastructure

The stack exports ports below.

- `5000`: Logstash TCP input
- `9200`: Elasticsearch HTTP
- `9300`: Elasticsearch TCP transport
- `80`: Kibana (Username: elastic, Password: changeme)

## 4.app

CMS application (can be replaced by other apps)

The application exports port `80`.

## 5.prometheus-grafana

Prometheus and Grafana

The application exports port ports below.

- `9090`: prometheus
- `9100`: node-exporter
- `80`: grafana (Username: admin, Password: changeme)

# To execute

cd to individual folder and use `../terraform.sh apply` to execute.

For example:
```
cd 1.s3-state
../terraform.sh init
../terraform.sh apply
```

# To check failure in a host

ssh to the host and execute `cat /var/log/cloud-init-output.log`
