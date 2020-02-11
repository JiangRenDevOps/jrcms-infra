# Description

This is the terraform project to create JRCMS infrastructure.

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

- 5000: Logstash TCP input
- 9200: Elasticsearch HTTP
- 9300: Elasticsearch TCP transport
- 5601: Kibana

## 4.app

CMS application (can be replaced by other apps)

The application exports port 80.

## 5.prometheus-grafana

Prometheus and Grafana

The application exports port ports below.



# To execute

cd to individual folder and use `../terraform.sh apply` to execute.

For example:
```
cd 1.s3-state
../terraform.sh apply
```

# To batch execute

execute `../setup_all.sh`


# To batch destroy

execute `../cleanup_all.sh` and remove the s3 bucket: s3-terraform-state-storage-* 

# To check failure in a host

ssh to the host and execute `cat /var/log/cloud-init-output.log`
