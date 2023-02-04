variable "aws_region" {
  description = "AWS region for KMS deployment"
}

variable "instance_type" {
  description = "Instance Type for Hippo APP EC2 instance"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
}