output "api_gateway_url" {
  value = aws_apigatewayv2_api.aws_api_demo.api_endpoint
}

output "alb_dns_name" {
  value = aws_lb.api.dns_name
}
