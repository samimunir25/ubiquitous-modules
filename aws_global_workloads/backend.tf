terraform {
  backend "s3" {
    bucket  = "ubiquitous-modules-terraform"
    key     = "aws_global_workloads/us-east-1/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}