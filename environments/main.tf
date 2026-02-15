terraform {
    required_providers {
        aws = {
            source  = "hashicorp/aws"
            version = "~> 4.0"
        }
    }
}

# configure the aws cli
provider "aws" {
  region = "us-east-1"
}

