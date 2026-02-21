data "aws_iam_role" "eks_cluster_role" {
  name = "LabRole"
}

data "aws_lamda_function" "scheduler" {
  function_name = "microservices-scheduler"
}
