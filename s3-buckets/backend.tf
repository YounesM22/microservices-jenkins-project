terraform {
  backend "s3" {
    bucket  = "younes-eks-terraform-state-2026"
    key     = "s3-buckets/terraform.tfstate"
    region  = "us-east-1"
    encrypt = true
  }
}
