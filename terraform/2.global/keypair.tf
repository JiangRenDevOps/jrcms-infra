module "key_pair" {
  source = "terraform-aws-modules/key-pair/aws"

  key_name   = "SSH key imported from laptop"
  public_key = "${data.local_file.public_key.content}"

}

data "local_file" "public_key" {
    filename = "/root/.ssh/id_rsa.pub"
}

output "key_pair_key_name" {
  value = "${module.key_pair.this_key_pair_key_name}"
}
