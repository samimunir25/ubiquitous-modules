# -------------------------------------------------------
# REQUIRED PARAMETERS
# You must provide a value for each of these parameters.
# -------------------------------------------------------

variable "instance_type" {
  description = "Instance Type for Hippo APP EC2 instance"
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