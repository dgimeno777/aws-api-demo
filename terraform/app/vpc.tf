data "aws_vpc" "vpc" {
  id = data.terraform_remote_state.terraform-aws-vpc.outputs.vpc_id
}

data "aws_subnet" "public_a" {
  id = data.terraform_remote_state.terraform-aws-vpc.outputs.subnet_public_a_id
}

data "aws_subnet" "public_b" {
  id = data.terraform_remote_state.terraform-aws-vpc.outputs.subnet_public_b_id
}

data "aws_subnet" "private_a" {
  id = data.terraform_remote_state.terraform-aws-vpc.outputs.subnet_private_a_id
}

data "aws_subnet" "private_b" {
  id = data.terraform_remote_state.terraform-aws-vpc.outputs.subnet_private_b_id
}
