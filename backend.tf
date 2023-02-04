terraform {
  backend "s3" {
    bucket  = "terraform-states-wa-integration"
    key     = "integration/services/cloudops-tmh-hippo/eu-west-1/terraform.tfstate"
    region  = "eu-west-1"
    encrypt = true
  }
}