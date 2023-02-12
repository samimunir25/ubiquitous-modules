# -------------------------------------------------------
# REQUIRED PARAMETERS
# Value for each of these parameters must be provided.
# -------------------------------------------------------

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

variable "subnet_tag" {
  description = "Tag for Subnet"
  type        = string
}

variable "route_table_tag" {
  description = "Tag for Route table"
  type        = string
}