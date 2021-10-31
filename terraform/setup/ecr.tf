resource "aws_ecr_repository" "aws_api_repo" {
  name = "aws-api-repo-${local.resource_name_suffix}/api"
  image_scanning_configuration {
    scan_on_push = true
  }
  encryption_configuration {
    encryption_type = "AES256"
  }
  tags = {
    (var.tag_project_key): local.tag_project_value
  }
}
