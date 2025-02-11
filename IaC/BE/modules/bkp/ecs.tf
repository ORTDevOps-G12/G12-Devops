resource "aws_ecs_task_definition" "backup_task" {
  family                   = "backup-task"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = "512"
  memory                   = "1024"

  container_definitions = jsonencode([
    {
      name      = "backup-container"
      image     = var.docker-image
      environment = [
        {
          name  = "CLUSTER"
          value = var.cluster_name
        },
         {
          name  = "TASK_DEFINITION"
          value = "backup-task-${var.object_name}"
        },
         {
          name  = "SUBNET_ID"
          value = var.cluster_name
        },
       
      ]
    }
  ])

  execution_role_arn = var.labrole_arn
  task_role_arn      = var.labrole_arn
}