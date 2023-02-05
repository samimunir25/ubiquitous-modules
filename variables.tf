variable "aws_region" {
  description = "AWS region for deployment"
}

variable "instance_type" {
  description = "Instance Type for Hippo APP EC2 instance"
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
}

variable "image_id" {
  description = "Ubuntu Server 22.04 LTS (HVM), SSD Volume Type. Architecture x86_64"
  type        = string
}

variable "alb_port" {
  description = "Listener port for ALB"
  type        = string

}