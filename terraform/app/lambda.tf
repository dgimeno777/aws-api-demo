resource "aws_iam_role" "aws_api_demo_lambda_exec" {
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "lambda.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.aws_api_demo_lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_lambda_function" "get_random_color" {
  function_name = "aws-api-demo-${local.resource_name_suffix}-get-random-color"
  role          = aws_iam_role.aws_api_demo_lambda_exec.arn
  package_type  = "Image"
  image_uri     = "${data.aws_ecr_repository.aws-api-demo-api.repository_url}:latest"
  image_config {
    command = ["api.lambda_handler.get_random_color.lambda_handler"]
  }
}

resource "aws_cloudwatch_log_group" "get_random_color" {
  name              = "/aws/lambda/${aws_lambda_function.get_random_color.function_name}"
  retention_in_days = 30
}

resource "aws_lambda_function" "is_color_valid" {
  function_name = "aws_api_demo-${local.resource_name_suffix}-is-color-valid"
  role          = aws_iam_role.aws_api_demo_lambda_exec.arn
  package_type  = "Image"
  image_uri     = "${data.aws_ecr_repository.aws-api-demo-api.repository_url}:latest"
  image_config {
    command = ["api.lambda_handler.is_color_valid.lambda_handler"]
  }
}

resource "aws_cloudwatch_log_group" "is_color_valid" {
  name              = "/aws/lambda/${aws_lambda_function.is_color_valid.function_name}"
  retention_in_days = 30
}
