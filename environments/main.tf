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

# modulo para guardar el tfstate remoto
module "terraform_state_backend" {
  source = "cloudposse/tfstate-backend/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version     = "x.x.x"
  namespace  = "tfg"
  stage      = "dev"
  name       = "azuar4e"
  attributes = ["state"]

  terraform_backend_config_file_path = "."
  terraform_backend_config_file_name = "backend.tf"
  force_destroy                      = true
}

# modules
module "dynamo" {
  source = "../modules/dynamo"
}

module "networks" {
  source = "../modules/networking"
}
module "eks" {
  source = "../modules/eks"

  private_subnet_ids = module.networks.private_subnet_ids
  cluster_role_arn   = data.aws_iam_role.eks_cluster_role.arn
  vpc_id             = module.networks.vpc_id
  region             = "us-east-1"
}

module "rds" {
  source = "../modules/rds"

  vpc_id                = module.networks.vpc_id
  private_subnet_ids    = module.networks.private_subnet_ids
  eks_cluster_security_group_id = module.eks.cluster_security_group_id
  db_password = var.db_password
}

module "route53" {
  source = "../modules/route53"

  vpc_id = module.networks.vpc_id
  rds_endpoint = module.rds.endpoint
}

module "cloudwatch" {
  source = "../modules/cloudwatch"

  lambda_function_name = data.aws_lambda_function.scheduler.function_name
  rds_instance_id      = module.rds.instance_id
  sqs_queue_name       = "microservices-queue"
  eks_cluster_name     = module.eks.name
}

# lambda event bridge configuration
resource "aws_cloudwatch_event_rule" "scheduler-event" {
  name                = "scheduler-event-active-jobs"
  schedule_expression = "rate(1 minute)"
}

resource "aws_cloudwatch_event_target" "lambda_target" {
  rule      = aws_cloudwatch_event_rule.scheduler-event.name
  target_id = "scheduler-lambda"
  arn       = data.aws_lambda_function.scheduler.arn
}

resource "aws_lambda_permission" "allow_eventbridge" {
  statement_id  = "AllowExecutionFromEventBridge"
  action        = "lambda:InvokeFunction"
  function_name = data.aws_lambda_function.scheduler.function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.scheduler-event.arn
}