data "aws_iam_role" "eks_cluster_role" {
  name = "LabRole"
}

data "aws_lambda_function" "scheduler" {
  function_name = "microservice-scheduler"
}
