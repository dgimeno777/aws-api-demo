data "aws_ecr_repository" "aws-api-demo-api" {
  name = "aws-api-repo-${local.resource_name_suffix}/api"
}
