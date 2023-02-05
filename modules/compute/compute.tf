### Launch Configuration for Auto Scaling Group ###

resource "aws_launch_configuration" "web_launch_config" {
  image_id        = var.image_id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.web_sg.id]

  user_data = templatefile("user-data.sh", {
    server_port = var.server_port
  })
              
  lifecycle {
    create_before_destroy = true
  }
}

### Security Group for Launch Configuration ###

resource "aws_security_group" "web_sg" {
  name = "${var.cluster_name}-web-sg"
  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = local.tcp_protocol
    cidr_blocks = local.all_ips
  }
}

### Auto Scaling Group ###

resource "aws_autoscaling_group" "web_asg" {
  launch_configuration = aws_launch_configuration.web_launch_config.name
  vpc_zone_identifier  = data.aws_subnets.default.ids

  target_group_arns = [aws_lb_target_group.alb_target_group.arn] ##
  health_check_type = "ELB"

  min_size = var.min_size
  max_size = var.max_size

  tag {
    key                 = "Name"
    value               = var.cluster_name
    propagate_at_launch = true
  }
}


data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

### Application Load Balancer ###

resource "aws_lb" "web_alb" {
  name               = var.cluster_name
  load_balancer_type = "application"
  subnets            = data.aws_subnets.default.ids
  security_groups    = [aws_security_group.alb_sg.id]
}

### Listener Rules for Application Load Balancer ###

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.web_alb.arn
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

### Security Group for Application Load Balancef ###

resource "aws_security_group" "alb_sg" {
  name = "${var.cluster_name}-alb-sg"
}

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.alb_sg.id

  from_port   = local.http_port
  to_port     = local.http_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.alb_sg.id

  from_port   = local.any_port
  to_port     = local.any_port
  protocol    = local.any_protocol
  cidr_blocks = local.all_ips
}

### Target Group for Application Load Balancer ###

resource "aws_lb_target_group" "alb_target_group" {
  name     = "web-alb-target-group"
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

resource "aws_lb_listener_rule" "alb_listener" {
  listener_arn = aws_lb_listener.http.arn
  priority     = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb_target_group.arn
  }
}

### Application Load Balancer - ARN ###

output "alb_dns_name" {
  value       = aws_lb.web_alb.dns_name
  description = "The domain name of the load balancer"
}

output "alb_security_group_id" {
  value       = aws_security_group.alb.id
  description = "The ID of the Security Group attached to the ALB"
}