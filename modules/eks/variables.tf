variable "private_subnet_ids" {
  type = list(string)
}

variable "cluster_role_arn" {
  type = string
}

variable "vpc_id"  {
  type = string
}

variable "region" {
  type = string
  default = "us-east-1"
}