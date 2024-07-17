# Define una VPC (si ya tienes una, omite esto)
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.0"

  name = "${terraform.workspace}-vpc-${var.project_name}"
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]

  enable_nat_gateway = false
  single_nat_gateway = false

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}

# Grupo de Seguridad
resource "aws_security_group" "ecs" {
  name        = "${terraform.workspace}-sg-${var.project_name}"
  description = "Allow HTTP inbound traffic"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Load Balancer
resource "aws_lb" "app" {
  name               = "${terraform.workspace}-lb-${var.project_name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs.id]
  subnets            = module.vpc.public_subnets
}

resource "aws_lb_target_group" "app" {
  name        = "${terraform.workspace}-tg-${var.project_name}"
  port        = 8080
  protocol    = "HTTP"
  vpc_id      = module.vpc.vpc_id
  target_type = "ip"
}

resource "aws_lb_listener" "app" {
  load_balancer_arn = aws_lb.app.arn
  port              = "8080"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app.arn
  }
}

# Cluster ECS
resource "aws_ecs_cluster" "main" {
  name = var.cluster_name
}

#cloudWatch
resource "aws_cloudwatch_log_group" "ecs_log_group" {
  name              = "/ecs/${terraform.workspace}-${var.project_name}-log-group"
  retention_in_days = 7
}

# Task Definition
resource "aws_ecs_task_definition" "products-task" {
  family                = "${terraform.workspace}-${var.products-service-backend-name}-task"
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "512"
  memory                = "1024"
  container_definitions = jsonencode([{
    name      = "cont-${var.products-service-backend-name}"
    image     = var.products-service-docker-image
    cpu       = 512
    memory    = 1024
    essential = true 
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
    }]
    logConfiguration = {
        logDriver = "awslogs"
        options = {
          "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name
          "awslogs-region"        = var.aws_region
          "awslogs-stream-prefix" = "ecs"
        }
    }
  }])

  execution_role_arn = var.labrole_arn
  task_role_arn = var.labrole_arn
}

# Task Definition
resource "aws_ecs_task_definition" "payments-task" {
  family                = "${terraform.workspace}-${var.payments-service-backend-name}-task"
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "512"
  memory                = "1024"
  container_definitions = jsonencode([{
    name      = "cont-${var.payments-service-backend-name}"
    image     = var.payments-service-docker-image
    cpu       = 512
    memory    = 1024
    essential = true 
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
    }]
    logConfiguration = {
          logDriver = "awslogs"
          options = {
            "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name
            "awslogs-region"        = var.aws_region
            "awslogs-stream-prefix" = "ecs"
          }
      }
  }]) 

  execution_role_arn = var.labrole_arn
  task_role_arn = var.labrole_arn
}

# Task Definition
resource "aws_ecs_task_definition" "shipping-task" {
  family                = "${terraform.workspace}-${var.shipping-service-backend-name}-task"
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "512"
  memory                = "1024"
  container_definitions = jsonencode([{
    name      = "cont-${var.shipping-service-backend-name}"
    image     = var.shipping-service-docker-image
    cpu       = 512
    memory    = 1024
    essential = true 
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
    }]
    logConfiguration = {
          logDriver = "awslogs"
          options = {
            "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name
            "awslogs-region"        = var.aws_region
            "awslogs-stream-prefix" = "ecs"
          }
      }
  }])

  execution_role_arn = var.labrole_arn
  task_role_arn = var.labrole_arn
}

resource "aws_ecs_task_definition" "orders-task" {
  family                   = "${terraform.workspace}-${var.orders-service-backend-name}-task"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  container_definitions    = jsonencode([{
    name  = "cont-${var.orders-service-backend-name}"
    image = var.orders-service-docker-image
    cpu       = 512
    memory    = 1024
    essential = true
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
    }]
    environment = [
      {
        name  = "BACKEND1_URL"
        value = "http://${aws_ecs_service.products-service.name}.${var.aws_region}.amazonaws.com"
      },
      {
        name  = "BACKEND2_URL"
        value = "http://${aws_ecs_service.payments-service.name}.${var.aws_region}.amazonaws.com"
      },
      {
        name  = "BACKEND3_URL"
        value = "http://${aws_ecs_service.shipping-service.name}.${var.aws_region}.amazonaws.com"
      }
    ]
    logConfiguration = {
          logDriver = "awslogs"
          options = {
            "awslogs-group"         = aws_cloudwatch_log_group.ecs_log_group.name
            "awslogs-region"        = var.aws_region
            "awslogs-stream-prefix" = "ecs"
          }
      }
  }])

  execution_role_arn = var.labrole_arn
  task_role_arn = var.labrole_arn

  depends_on = [ aws_ecs_service.products-service, aws_ecs_service.payments-service, aws_ecs_service.shipping-service ]
}

# ECS Service
resource "aws_ecs_service" "products-service" {
  name            = "${terraform.workspace}-${var.products-service-backend-name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.products-task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets = module.vpc.public_subnets
    security_groups = [module.vpc.default_security_group_id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "cont-${var.products-service-backend-name}"
    container_port   = 8080
  }
  depends_on = [aws_lb_listener.app]
}

resource "aws_ecs_service" "payments-service" {
  name            = "${terraform.workspace}-${var.payments-service-backend-name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.payments-task.arn 
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets = module.vpc.public_subnets
    security_groups = [module.vpc.default_security_group_id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "cont-${var.payments-service-backend-name}"
    container_port   = 8080
  }
  depends_on = [aws_lb_listener.app]
}

resource "aws_ecs_service" "shipping-service" {
  name            = "${terraform.workspace}-${var.shipping-service-backend-name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.shipping-task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets = module.vpc.public_subnets
    security_groups = [module.vpc.default_security_group_id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "cont-${var.shipping-service-backend-name}"
    container_port   = 8080
  }
  depends_on = [aws_lb_listener.app]
}

resource "aws_ecs_service" "orders-service" {
  name            = "${terraform.workspace}-${var.orders-service-backend-name}-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.orders-task.arn
  desired_count   = 1
  launch_type     = "FARGATE"
 network_configuration {
    subnets = module.vpc.public_subnets
    security_groups = [module.vpc.default_security_group_id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "cont-${var.orders-service-backend-name}"
    container_port   = 8080
  }
 depends_on = [aws_lb_listener.app]
}

module "backup" {
  source = "./modules/bkp"
  cluster_name = var.cluster_name
  labrole_arn = var.labrole_arn
  products-service-docker-image = var.products-service-docker-image
  subnets = module.vpc.public_subnets
}