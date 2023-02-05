## Data Block for importing VPN and Subnet IDs ###

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

### Launch Configuration for Auto Scaling Group ###

resource "aws_launch_configuration" "web_launch_configuration" {
  image_id        = var.image_id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.web_security_group.id]

  user_data = templatefile("${path.module}/user-data.sh", {
    server_port = var.server_port
  })
              
  lifecycle {
    create_before_destroy = true
  }
}

### Auto Scaling Group ###

resource "aws_autoscaling_group" "web_autoscaling_group" {
  launch_configuration = aws_launch_configuration.web_launch_configuration.name
  vpc_zone_identifier  = data.aws_subnets.default.ids

  target_group_arns = [aws_lb_target_group.web_alb_target_group.arn]
  health_check_type = "ELB"

  min_size = var.min_size
  max_size = var.max_size

  tag {
    key                 = "Name"
    value               = var.cluster_name
    propagate_at_launch = true
  }
}

### Security Group for Launch Configuration ###

resource "aws_security_group" "web_security_group" {
  name = "${var.cluster_name}-web-security-group"
  
}

resource "aws_security_group_rule" "allow_web_security_group_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.web_security_group.id

  from_port   = var.server_port
  to_port     = var.server_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

### Application Load Balancer ###

resource "aws_lb" "web_application_loadbalancer" {
  name               = var.cluster_name
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [aws_security_group.alb_security_group.id]
}

### Security Group for Application Load Balancer ###

resource "aws_security_group" "alb_security_group" {
  name = "${var.cluster_name}-alb-security-group"
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.alb_security_group.id

  from_port   = local.http_port
  to_port     = local.http_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.alb_security_group.id

  from_port   = local.any_port
  to_port     = local.any_port
  protocol    = local.any_protocol
  cidr_blocks = local.all_ips
}

### Listener Rules for Application Load Balancer ###

resource "aws_lb_listener" "http_alb_listener" {
  load_balancer_arn = aws_lb.web_application_loadbalancer.arn
  port              = local.http_port
  protocol          = "HTTP"

  # By default, return a simple 404 page
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code  = 404
    }
  }
}


### Target Group for Application Load Balancer ###

resource "aws_lb_target_group" "web_alb_target_group" {
  name     = var.cluster_name
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = data.aws_vpc.default.id

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
    interval            = 15
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

### Attaching Listener Rule to Targer Group ###

resource "aws_lb_listener_rule" "web_alb_listener_rule" {
  listener_arn = aws_lb_listener.http_alb_listener.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_alb_target_group.arn
  }
}

### Application Load Balancer - ARN ###

output "alb_dns_name" {
  value       = aws_lb.web_application_loadbalancer.dns_name
  description = "The domain name of the load balancer"
}