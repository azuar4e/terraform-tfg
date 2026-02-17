terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.32.1"
    }
  }
}

# configure the aws cli
provider "aws" {
  region = "us-east-1"
}

module "dynamo" {
  source = "../modules/dynamo"
}

module "networks" {
  source = "../modules/networking"
}
module "rds" {
  source = "../modules/rds"

  vpc_id = module.networks.vpc_id
  private_subnet_ids = module.networks.private_subnet_ids
  db_password = var.db_password
}