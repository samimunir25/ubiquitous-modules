![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/sammunir25/ubiquitous-modules)
![GitHub](https://img.shields.io/github/license/sammunir25/ubiquitous-modules)

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
.
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
    ├── compute
    │   ├── compute.tf
    │   ├── locals.tf
    │   ├── user-data.sh
    │   └── variables.tf
    └── core-infra
        ├── core-infra.tf
        └── variables.tf

```

## Note on Reusable Modules

At this phase of project, there two reusable modules hosted in this repo.
1. *core-infra* - This module is used for creating custom VPC
2. *compute* - This module is used for creating Auto Scaling Group with Appliction Load Balancer.

Modules are released with tags. This helps avoiding break-changes in new releases to impact earlier module version.\
At this phase of project,
- tag v0.0.2 of *compute* module is for creating AWS workloads in default VPC.\
  Make sure to comment *custom_vpc* module in *aws_live_workloads\main.tf* if workloads are to be deployed in default VPC.

- tag v0.0.6 of *compute* module is for creating ASG/ALB in custom VPC.
- tag v0.0.5 of *core-infra* module is for creating custom VPC and its moving parts, i.e. IGW, Subnets, Route Table, Subnet association.

## Examples 

To deploy custom VPC, with subnets, route tables, internet gateway and subnet associations, use below source URL in your root module.

```javascript
module "custom_vpc" {
  source = "github.com/samimunir25/ubiquitous-modules//modules/core-infra?ref=v0.0.5"

  vpc_cidr_block             = var.vpc_cidr_block
  vpc_tag                    = var.vpc_tag
  igw_tag                    = var.igw_tag
  subnet_a_cidr_block        = var.subnet_a_cidr_block
  subnet_a_availability_zone = var.subnet_a_availability_zone
  subnet_b_cidr_block        = var.subnet_b_cidr_block
  subnet_b_availability_zone = var.subnet_b_availability_zone
  subnet_tag                 = var.subnet_tag
  route_table_tag            = var.route_table_tag
}
```

To deploy Auto Scaling Group with Application Load Balancer in **default VPC**, use below source URL in your root module.
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
To deploy Auto Scaling Group with Application Load Balancer in **custom VPC**, use below source URL in your root module.
```javascript
module "webserver_cluster" {
  source = "github.com/samimunir25/ubiquitous-modules//modules/compute?ref=v0.0.6"

  cluster_name  = "webserver-stage"
  vpc_id        = module.custom_vpc.this_vpc_id
  instance_type = var.instance_type
  image_id      = var.image_id
  min_size      = var.min_size
  max_size      = var.max_size
  server_port   = var.server_port
}
```
## Note on AMI_ID and VPC_ID

*terraform.tfvars* contains AMI_ID and VPC_ID values which needs to be unique to your environment.
- Ensure the AMI_ID is for image which supports base x86_64 architecture.
- The AMI in this code example is hosted in **us-east-1** region. 
- If you wish to deploy your infrastructure in other AWS region, you need to provide AMI ID as per that region (*which supports base x86_64 architecture*).
- If you choose to create custom VPC with *core-infra* module, then *webserver_cluster* module in *aws_live_workloads\main.tf* has input        configured to refer to the VPC_ID which was created from *core-infra* module.

## Note on Remote Backend

Root module is configured to use S3 backened. In your scenario, replace bucket, key and region according to your AWS account.\
There is no resuable module used for it. 

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
## Time to Deplpoy 

- Fun Fact: If configured correctly, there are total 18 resources which these modules will deploy in AWS. 
- Approx time terraform takes to deploy all these resources are under 4 minutes.
- Have Fun