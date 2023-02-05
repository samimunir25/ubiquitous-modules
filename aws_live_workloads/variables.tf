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