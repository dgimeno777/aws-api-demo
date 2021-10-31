resource "aws_iam_role" "aws_api_demo_get_random_color" {
  assume_role_policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
      {
        "Effect": "Allow",
        "Principal": {
          "Service": "lambda.amazonaws.com"
        },
        "Action": "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_lambda_function" "aws_api_demo_get_random_color" {
  function_name = "aws-api-demo-${local.resource_name_suffix}-get-random-color"
  role          = aws_iam_role.aws_api_demo_get_random_color.arn
  package_type = "Image"
  image_uri = "${data.aws_ecr_repository.aws-api-demo-api.repository_url}:latest"
  image_config {
    command = ["poetry", "run", "python", "-m", "api.lambda_handler.get_random_color.get_random_color_lambda_handler"]
  }
}
