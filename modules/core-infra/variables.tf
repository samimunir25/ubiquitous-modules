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

variable "nat_gw_tag" {
  description = "Tag for NAT Gateway"
  type        = string
}

variable "public_subnet_a_cidr_block" {
  description = "Subnet A CIDR Block"
  type        = string
}

variable "public_subnet_b_cidr_block" {
  description = "Subnet B CIDR Block"
  type        = string
}

variable "pub_subnet_tag" {
  description = "Tag for Public Subnet"
  type        = string
}

variable "pub_route_table_tag" {
  description = "Tag for Route table"
  type        = string
}

variable "private_subnet_a_cidr_block" {
  description = "Private Subnet A CIDR Block"
  type        = string
}

variable "private_subnet_b_cidr_block" {
  description = "Private Subnet B CIDR Block"
  type        = string
}

variable "prv_subnet_tag" {
  description = "Tag for Public Subnet"
  type        = string
}

variable "availability_zone_a" {
  description = "AZ for Subnet A"
  type        = string
}

variable "availability_zone_b" {
  description = "AZ for Subnet B"
  type        = string
}

variable "prv_route_table_tag" {
  description = "Tag for Private Subnet"
  type        = string
}