module "custom_vpc" {
  source = "github.com/samimunir25/ubiquitous-modules//modules/core-infra?ref=v0.0.8"

  vpc_cidr_block              = "10.0.0.0/16"
  vpc_tag                     = "My_Custom_VPC"
  igw_tag                     = "My_Custom_IGW"
  nat_gw_tag                  = "My_Public_NAT-GW"
  availability_zone_a         = "us-east-1a"
  public_subnet_a_cidr_block  = "10.0.1.0/24"
  private_subnet_a_cidr_block = "10.0.11.0/24"
  availability_zone_b         = "us-east-1b"
  public_subnet_b_cidr_block  = "10.0.2.0/24"
  private_subnet_b_cidr_block = "10.0.22.0/24"
  pub_subnet_tag              = "Public_Subnet"
  prv_subnet_tag              = "Private_Subnet"
  pub_route_table_tag         = "Public_Route_Table"
  prv_route_table_tag         = "Private_Route_Table"

}

module "webserver_cluster" {
  source = "github.com/samimunir25/ubiquitous-modules//modules/compute?ref=v0.0.8"

  cluster_name  = "webserver-stage"
  vpc_id        = module.custom_vpc.this_vpc_id
  instance_type = "t2.small"
  image_id      = "ami-00874d747dde814fa"
  min_size      = "2"
  max_size      = "2"
  server_port   = "8080"
  depends_on = [
    module.custom_vpc
  ]
}

