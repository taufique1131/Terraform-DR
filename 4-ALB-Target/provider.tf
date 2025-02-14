terraform {
    backend "s3" {
      bucket = "praneeta-test-s3-copy-files"
      key = "Terraform/alb-alb-target-state-file"
      region = "ap-south-1"
    }
    required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "5.85.0"
    }

    }
}

provider "aws" {
  region = "ap-south-2" 
}