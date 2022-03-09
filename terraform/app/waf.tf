resource "aws_wafv2_ip_set" "api" {
  name               = "aws-api-demo-ip-set-${local.resource_name_suffix}"
  scope              = "REGIONAL"
  ip_address_version = "IPV4"
  addresses          = [local.my_public_ip_cidr]
}

resource "aws_wafv2_rule_group" "api" {
  capacity = 2
  name     = "aws-api-demo-${local.resource_name_suffix}"
  scope    = "REGIONAL"
  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "aws-api-demo-rule-group-${local.resource_name_suffix}"
    sampled_requests_enabled   = false
  }
  rule {
    name     = "aws-api-demo-rule-group-rule-100"
    priority = 100
    action {
      allow {}
    }
    statement {
      geo_match_statement {
        country_codes = ["US"]
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "aws-api-demo-rule-group-rule-100"
      sampled_requests_enabled   = false
    }
  }
  rule {
    name     = "aws-api-demo-rule-group-rule-200"
    priority = 200
    action {
      allow {}
    }
    statement {
      ip_set_reference_statement {
        arn = aws_wafv2_ip_set.api.arn
      }
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "aws-api-demo-rule-group-rule-200"
      sampled_requests_enabled   = false
    }
  }
}

resource "aws_wafv2_web_acl" "api" {
  name  = "aws-api-demo-${local.resource_name_suffix}"
  scope = "REGIONAL"
  default_action {
    block {}
  }
  rule {
    name     = "aws-api-demo-web-acl-rule-1"
    priority = 1
    statement {
      rule_group_reference_statement {
        arn = aws_wafv2_rule_group.api.arn
      }
    }
    override_action {
      none {}
    }
    visibility_config {
      cloudwatch_metrics_enabled = false
      metric_name                = "aws-api-demo-web-acl-rule-1"
      sampled_requests_enabled   = false
    }
  }
  visibility_config {
    cloudwatch_metrics_enabled = false
    metric_name                = "aws-api-demo-web-acl-${local.resource_name_suffix}"
    sampled_requests_enabled   = false
  }
}

resource "aws_wafv2_web_acl_association" "api" {
  resource_arn = aws_lb_listener.api.arn
  web_acl_arn  = aws_wafv2_web_acl.api.arn
}
