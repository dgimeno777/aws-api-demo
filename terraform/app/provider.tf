terraform {
  backend "s3" {
    bucket  = "dgimeno-repos"
    key     = "aws-api-demo/s3/app/terraform.tfstate"
    region  = "us-east-1"
    profile = "aws-api-demo"
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 4.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "aws-api-demo"
}

data "terraform_remote_state" "terraform-aws-vpc" {
  backend   = "s3"
  workspace = var.terraform_aws_vpc_workspace
  config = {
    bucket  = "dgimeno-repos"
    key     = "terraform-aws-vpc/vpc/terraform.tfstate"
    region  = var.aws_region
    profile = var.aws_profile
  }
}
