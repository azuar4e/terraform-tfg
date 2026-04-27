variable "private_subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}
variable "eks_cluster_security_group_id" {
  type = string
}

variable "db_password" {
  type = string
}