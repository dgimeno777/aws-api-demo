resource "aws_apigatewayv2_api" "aws_api_demo" {
  name          = "aws-api-demo-${local.resource_name_suffix}"
  protocol_type = "HTTP"
}

resource "aws_apigatewayv2_stage" "lambda" {
  api_id      = aws_apigatewayv2_api.aws_api_demo.id
  name        = "aws-api-demo-${local.resource_name_suffix}"
  auto_deploy = true
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
  api_id           = aws_apigatewayv2_api.aws_api_demo.id
  integration_type = "AWS_PROXY"
  integration_uri = aws_lambda_function.is_color_valid.invoke_arn
  integration_method = "POST"
}

resource "aws_apigatewayv2_route" "is_color_valid" {
  api_id    = aws_apigatewayv2_api.aws_api_demo.id
  route_key = "GET /is_color_valid"
  target = "integrations/${aws_apigatewayv2_integration.is_color_valid.id}"
}

resource "aws_lambda_permission" "is_color_valid" {
  statement_id = "AllowExecutionFromAPIGateway"
  action = "lambda:InvokeFunction"
  function_name = aws_lambda_function.is_color_valid.function_name
  principal = "apigateway.amazonaws.com"
  source_arn = "${aws_apigatewayv2_api.aws_api_demo.execution_arn}/*/*"
}
