variable "aws_region" {
  description = "Region for AWS workloads deplooyment"
  type        = string
}

variable "image_id" {
  description = "Ubuntu Server 22.04 LTS (HVM), SSD Volume Type. Architecture x86_64"
  type        = string
}

variable "instance_type" {
  description = "Instance Type for Hippo APP EC2 instance"
  type        = string
}

variable "min_size" {
  description = "The minimum number of EC2 Instances in the ASG"
  type        = number
}

variable "max_size" {
  description = "The maximum number of EC2 Instances in the ASG"
  type        = number
}

variable "server_port" {
  description = "The port the server will use for HTTP requests"
  type        = number
}

variable "vpc_id" {
  description = "VPC ID where the module is to be executed"
  type        = string
}