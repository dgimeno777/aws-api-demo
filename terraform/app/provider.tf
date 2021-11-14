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
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "aws-api-demo"
}
