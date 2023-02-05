terraform {
  backend "s3" {
    bucket  = "remote-state-065374699403"
    key     = "us-east-1/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}