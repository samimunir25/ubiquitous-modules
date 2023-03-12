# -------------------------------------------------------
# REQUIRED PARAMETERS
# Value for each of these parameters must be provided.
# -------------------------------------------------------

variable "instance_type" {
  description = "Instance Type for Auto Scaling Group"
  type        = string
}

variable "image_id" {
  description = "AMI ID to be used by Auto Scaling Group"
  type        = string
}


variable "cluster_name" {
  description = "The name to use for all the cluster resources"
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