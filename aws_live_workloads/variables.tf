#### Core-Infra Variables ###

variable "vpc_cidr_block" {
  description = "CIDR Block for VPC"
  type        = string
}

variable "vpc_tag" {
  description = "Tag for VPC"
  type        = string
}
variable "igw_tag" {
  description = "Tag for Internet Gateway"
  type        = string
}

variable "subnet_a_cidr_block" {
  description = "Subnet A CIDR Block"
  type        = string
}

variable "subnet_b_cidr_block" {
  description = "Subnet B CIDR Block"
  type        = string
}

variable "subnet_a_availability_zone" {
  description = "AZ for Subnet A"
  type        = string
}

variable "subnet_b_availability_zone" {
  description = "AZ for Subnet B"
  type        = string
}

variable "subnet_tag" {
  description = "Tag for Subnet"
  type        = string
}

variable "route_table_tag" {
  description = "Tag for Route table"
  type        = string
}

### Compute Variables ###

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


