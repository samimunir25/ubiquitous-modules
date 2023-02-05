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

variable "image_id" {
  description = "Amazon Linux 2 AMI (HVM) - Kernel 5.10, SSD Volume Type"
  type = string
 }

 variable "alb_port" {
  description = "Listener port for ALB"
  type = string
   
 }