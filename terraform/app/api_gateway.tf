resource "aws_apigatewayv2_api" "aws_api_demo" {
  name          = "aws-api-demo-${local.resource_name_suffix}"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "lambda" {
  api_id      = aws_apigatewayv2_api.aws_api_demo.id
  name        = "aws-api-demo-${local.resource_name_suffix}"
  auto_deploy = true
}

resource "aws_security_group" "api" {
  name = "aws-api-demo-vpc-link-${local.resource_name_suffix}"
  vpc_id = data.aws_vpc.vpc.id
  ingress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    security_groups = [
      aws_security_group.alb.id
    ]
  }
  egress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    security_groups = [
      aws_security_group.alb.id
    ]
  }
}

resource "aws_apigatewayv2_vpc_link" "api" {
  name        = "aws-api-demo-${local.resource_name_suffix}"
  security_group_ids = [
    aws_security_group.api.id
  ]
  subnet_ids = [
    data.aws_subnet.private_a.id
  ]
}

resource "aws_apigatewayv2_integration" "vpc" {
  api_id           = aws_apigatewayv2_api.aws_api_demo.id
  integration_type = "HTTP_PROXY"
  integration_method = "ANY"
  connection_type = "VPC_LINK"
  connection_id = aws_apigatewayv2_vpc_link.api.id
  integration_uri = aws_lb.api.arn
}

resource "aws_apigatewayv2_route" "default_route" {
  api_id    = aws_apigatewayv2_api.aws_api_demo.id
  route_key = "$default"
  target    = "integrations/${aws_apigatewayv2_integration.vpc.id}"
}

resource "aws_apigatewayv2_integration" "get_random_color" {
  api_id             = aws_apigatewayv2_api.aws_api_demo.id
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.get_random_color.invoke_arn
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "get_random_color" {
  api_id    = aws_apigatewayv2_api.aws_api_demo.id
  route_key = "GET /get_random_color"
  target    = "integrations/${aws_apigatewayv2_integration.get_random_color.id}"
}

resource "aws_lambda_permission" "get_random_color" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.get_random_color.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.aws_api_demo.execution_arn}/*/*"
}

resource "aws_apigatewayv2_integration" "is_color_valid" {
  api_id             = aws_apigatewayv2_api.aws_api_demo.id
  integration_type   = "AWS_PROXY"
  integration_uri    = aws_lambda_function.is_color_valid.invoke_arn
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "is_color_valid" {
  api_id    = aws_apigatewayv2_api.aws_api_demo.id
  route_key = "GET /is_color_valid"
  target    = "integrations/${aws_apigatewayv2_integration.is_color_valid.id}"
}

resource "aws_lambda_permission" "is_color_valid" {
  statement_id  = "AllowExecutionFromAPIGateway"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.is_color_valid.function_name
  principal     = "apigateway.amazonaws.com"
  source_arn    = "${aws_apigatewayv2_api.aws_api_demo.execution_arn}/*/*"
}
