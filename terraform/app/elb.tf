resource "aws_lb" "api" {
  name = "aws-api-demo-${local.resource_name_suffix}"
  internal = false
  load_balancer_type = "application"
  subnets = [
    data.aws_subnet.public_a.id,
    data.aws_subnet.public_b.id,
  ]
  security_groups = [
    aws_security_group.alb.id
  ]
  enable_deletion_protection = false
}

resource "aws_lb_target_group" "api" {
  name = "aws-api-demo-${local.resource_name_suffix}"
  port = 443
  protocol = "HTTPS"
  target_type = "ip"
  vpc_id = data.aws_vpc.vpc.id
}

resource "aws_lb_listener" "api" {
  load_balancer_arn = aws_lb.api.arn
  port = 443
  protocol = "HTTPS"
  ssl_policy = "ELBSecurityPolicy-2016-08"
  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.api.arn
  }
}

resource "aws_security_group" "alb" {
  name = "aws-api-demo-alb-${local.resource_name_suffix}"
  vpc_id = data.aws_vpc.vpc.id
  ingress {
    protocol  = "tcp"
    from_port = 443
    to_port   = 443
    cidr_blocks = [
      local.my_public_ip_cidr
    ]
  }
  egress {
    protocol  = "-1"
    from_port = 0
    to_port   = 0
    cidr_blocks = [
      "0.0.0.0/0"
    ]
  }
  tags = {
    Name: "aws-api-demo-alb-${local.resource_name_suffix}"
  }
}