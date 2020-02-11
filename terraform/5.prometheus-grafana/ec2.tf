module "ec2_cluster" {
  source                 = "terraform-aws-modules/ec2-instance/aws"
  version                = "~> 2.0"

  name                   = "prometheus-grafana"
  instance_count         = 1

  ami                    = "ami-07ebfd5b3428b6f4d"
  instance_type          = "t2.micro"
  key_name               = "${data.terraform_remote_state.global_state.outputs.key_pair_key_name}"
  vpc_security_group_ids = ["${data.terraform_remote_state.global_state.outputs.all_sg_id}"]
  subnet_id              = "${data.terraform_remote_state.global_state.outputs.public_subnets[0]}"

  user_data_base64       = "${base64encode(replace("${data.local_file.init_script.content}", "APP_IP_PLACEHOLDER", "${data.terraform_remote_state.app.outputs.ec2_ip}"))}"
  tags = {
    Name        = "prometheus-grafana"
    Terraform   = "true"
    Project     = "jrcms"
  }
}
data "local_file" "init_script" {
    filename = "scripts/init_script.sh"
}

output "grafana_ip" {
  value = "${module.ec2_cluster.public_ip[0]}"
}

output "jrcms_ip" {
  value = "${data.terraform_remote_state.app.outputs.ec2_ip}"
}


output "elk_ip" {
  value = "${data.terraform_remote_state.elk.outputs.ec2_ip}"
}
