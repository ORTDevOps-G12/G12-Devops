resource "aws_lambda_function" "ecs_backup" {
  filename         = "lambda_function_payload.zip"
  function_name    = "ecs_backup"
  role             = var.labrole_arn
  handler          = "lambda_backup.lambda_handler"
  source_code_hash = filebase64sha256("lambda_function_payload.zip")
  runtime          = "python3.8"

  environment {
    variables = {
      CLUSTER          = var.cluster_name
      TASK_DEFINITION  = "backup-task"
      SUBNET_ID        = var.subnets[0]
    }
  }
}