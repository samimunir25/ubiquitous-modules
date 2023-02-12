# module "webserver_cluster" {
#   source = "github.com/samimunir25/ubiquitous-modules//modules/compute?ref=v0.0.3"

#   cluster_name  = "webserver-stage"
#   vpc_id        = var.vpc_id
#   instance_type = var.instance_type
#   image_id      = var.image_id
#   min_size      = var.min_size
#   max_size      = var.max_size
#   server_port   = var.server_port
# }

module "vpc" {
  source = "../modules/core-infra/"

  vpc_cidr_block    = var.vpc_cidr_block
  vpc_tag           = var.vpc_tag
  igw_tag           = var.igw_tag
  subnet_cidr_block = var.subnet_cidr_block
  subnet_tag        = var.subnet_tag
  route_table_tag   = var.route_table_tag
}

