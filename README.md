# ubiquitous-modules
Reusable modules for terraform

This repo contains example for creating below AWS workloads:
1. Application Load Balancer
2. Auto Scaling Group
3. Launch Configuration for ASG
4. Terraform remote backend confiured to use S3 bucket


## Note on Reusable Module 

To deploy Auto Scaling Group with Application Load Balancer in default VPC, use below source URL in your root module.
```json
module "webserver_cluster" {
  source = "github.com/samimunir25/ubiquitous-modules//modules/compute?ref=v0.0.2"

  cluster_name  = "webserver-stage"
  instance_type = var.instance_type
  image_id      = var.image_id
  min_size      = var.min_size
  max_size      = var.max_size
  server_port   = var.server_port
}
```
To deploy Auto Scaling Group with Application Load Balancer in custom VPC, use below source URL in your root module.
```json
module "webserver_cluster" {
  source = "github.com/samimunir25/ubiquitous-modules//modules/compute?ref=v0.0.3"

  cluster_name  = "webserver-stage"
  vpc_id        = var.vpc_id
  instance_type = var.instance_type
  image_id      = var.image_id
  min_size      = var.min_size
  max_size      = var.max_size
  server_port   = var.server_port
}
```