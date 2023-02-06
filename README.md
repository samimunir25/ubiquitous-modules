# ubiquitous-modules
Reusable modules for terraform

This repo contains example for creating below AWS workloads:
1. Application Load Balancer
2. Auto Scaling Group
3. Launch Configuration for ASG
4. Terraform remote backend confiured to use S3 bucket

## Note on Directory Strucutre
This repo is setup in modular structure.\
*aws_global_workloads* directory is not using reusable modules. It contians codebase for creating S3 bucket to store terraform.tfstate file.\
*aws_live_workloads* directory is focus of this repo. It contains root module for ASG and ALB, and uses child module to deploy the workloads.\
*modules* directory contains reusable module.

```
└── ubiquitous-modules
    ├── LICENSE
    ├── README.md
    ├── aws_global_workloads
    │   ├── backend.tf
    │   ├── backend_s3.tf
    │   ├── provider.tf
    │   ├── terraform.tfvars
    │   └── variables.tf
    ├── aws_live_workloads
    │   ├── backend.tf
    │   ├── main.tf
    │   ├── output.tf
    │   ├── providers.tf
    │   ├── terraform.tfvars
    │   └── variables.tf
    └── modules
        └── compute
            ├── compute.tf
            ├── locals.tf
            ├── user-data.sh
            └── variables.tf

```

## Note on Reusable Module 

To deploy Auto Scaling Group with Application Load Balancer in default VPC, use below source URL in your root module.
```javascript
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
```javascript
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
## Note on Remote Backend

Root module is configured to use S3 backened. In your scenario, replace bucket, key and region according to your AWS account.

```javascript
terraform {
  backend "s3" {
    bucket  = "<YOUR_UNIQUE_BUCKET>"
    key     = "<directory/to/your/terraform.tfstate>"
    region  = "<YOUR_AWS_REGION>"
    encrypt = true
  }
}
```