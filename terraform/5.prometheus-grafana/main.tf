provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {}
}

data "terraform_remote_state" "s3_state" {
    backend = "local"
    config = {
        path = "../1.s3-state/terraform.tfstate"
    }
}

data "terraform_remote_state" "global_state" {
    backend = "s3"
    config = {
        bucket = "${data.terraform_remote_state.s3_state.outputs.bucket_raw}"
        key    = "2.global/terraform.tfstate"
        region = "${data.terraform_remote_state.s3_state.outputs.region_raw}"
    }
}

data "terraform_remote_state" "elk" {
    backend = "s3"
    config = {
        bucket = "${data.terraform_remote_state.s3_state.outputs.bucket_raw}"
        key    = "3.elk/terraform.tfstate"
        region = "${data.terraform_remote_state.s3_state.outputs.region_raw}"
    }
}
data "terraform_remote_state" "app" {
    backend = "s3"
    config = {
        bucket = "${data.terraform_remote_state.s3_state.outputs.bucket_raw}"
        key    = "4.app/terraform.tfstate"
        region = "${data.terraform_remote_state.s3_state.outputs.region_raw}"
    }
}
