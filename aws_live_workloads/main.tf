# module "custom_vpc" {
#   source = "github.com/samimunir25/ubiquitous-modules//modules/core-infra?ref=v0.0.4"

#   vpc_cidr_block      = var.vpc_cidr_block
#   vpc_tag             = var.vpc_tag
#   igw_tag             = var.igw_tag
#   subnet_a_cidr_block = var.subnet_a_cidr_block
#   subnet_b_cidr_block = var.subnet_b_cidr_block
#   subnet_tag          = var.subnet_tag
#   route_table_tag     = var.route_table_tag
# }

# module "webserver_cluster" {
#   source = "github.com/samimunir25/ubiquitous-modules//modules/compute?ref=v0.0.3"

#   cluster_name  = "webserver-stage"
#   vpc_id        = module.custom_vpc.this_vpc_id
#   instance_type = var.instance_type
#   image_id      = var.image_id
#   min_size      = var.min_size
#   max_size      = var.max_size
#   server_port   = var.server_port

# }

module "store_write" {
  source  = "https://github.com/samimunir25/terraform-aws-ssm-parameter-store?ref=v0.9.1"

  parameter_write = [
    {
      name        = "/cp/prod/app/database/master_password"
      value       = "password1"
      type        = "String"
      overwrite   = "true"
      description = "Production database master password"
    }
  ]

  tags = {
    ManagedBy = "Terraform"
  }
}
