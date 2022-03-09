locals {
  resource_name_suffix = terraform.workspace
  tag_project_value    = "aws-api-demo"
}

variable "tag_project_key" {
  type        = string
  description = "The project tag key"
  default     = "Project"
}

variable "aws_region" {
  type        = string
  description = "AWS Region"
  default     = "us-east-1"
}

variable "aws_profile" {
  type        = string
  description = "AWS CLI Profile"
  default     = "aws_ssh_hub"
}

variable "terraform_aws_vpc_workspace" {
  type        = string
  description = "Workspace of the terraform-aws-vpc remote state"
  default     = "default"
}
