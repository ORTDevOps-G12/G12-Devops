# Define una VPC (si ya tienes una, omite esto)
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "3.18.0"

  name = var.vpc_name
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b"]
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]

  enable_nat_gateway = false
  single_nat_gateway = false

  tags = {
    Terraform   = "true"
    Environment = var.environment_name
  }
}

# Grupo de Seguridad
resource "aws_security_group" "ecs" {
  name        = var.security_group_name
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
  name               = var.load_balancer_name
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ecs.id]
  subnets            = module.vpc.public_subnets
}

resource "aws_lb_target_group" "app" {
  name        = var.target_group_name
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

# Task Definition
resource "aws_ecs_task_definition" "backend1" {
  family                = "backend1"
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "512"
  memory                = "1024"
  container_definitions = jsonencode([{
    name      = "backend1-cont"
    image     = var.backend_image1
    cpu       = 512
    memory    = 1024
    essential = true 
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
    }]
  }])

  execution_role_arn = var.labrole_arn
  task_role_arn = var.labrole_arn
}

# Task Definition
resource "aws_ecs_task_definition" "backend2" {
  family                = "backend2"
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "512"
  memory                = "1024"
  container_definitions = jsonencode([{
    name      = "backend2-cont"
    image     = var.backend_image2
    cpu       = 512
    memory    = 1024
    essential = true 
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
    }]
  }])

  execution_role_arn = var.labrole_arn
  task_role_arn = var.labrole_arn
}

# Task Definition
resource "aws_ecs_task_definition" "backend3" {
  family                = "backend3"
  network_mode          = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                   = "512"
  memory                = "1024"
  container_definitions = jsonencode([{
    name      = "backend3-cont"
    image     = var.backend_image3
    cpu       = 512
    memory    = 1024
    essential = true 
    portMappings = [{
      containerPort = 8080
      hostPort      = 8080
    }]
  }])

  execution_role_arn = var.labrole_arn
  task_role_arn = var.labrole_arn
}

resource "aws_ecs_task_definition" "backend4" {
  family                   = "backend4"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "512"
  memory                   = "1024"
  container_definitions    = jsonencode([{
    name  = "backend4-cont"
    image = var.backend_image4
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
        value = "http://${aws_ecs_service.backend1.name}.${var.aws_region}.amazonaws.com"
      },
      {
        name  = "BACKEND2_URL"
        value = "http://${aws_ecs_service.backend2.name}.${var.aws_region}.amazonaws.com"
      },
      {
        name  = "BACKEND3_URL"
        value = "http://${aws_ecs_service.backend3.name}.${var.aws_region}.amazonaws.com"
      }
    ]
  }])

  execution_role_arn = var.labrole_arn
  task_role_arn = var.labrole_arn
}

# ECS Service
resource "aws_ecs_service" "backend1" {
  name            = "backend1-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.backend1.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = module.vpc.public_subnets
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "backend1-cont"
    container_port   = 8080
  }
  depends_on = [aws_lb_listener.app]
}

resource "aws_ecs_service" "backend2" {
  name            = "backend2-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.backend2.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = module.vpc.public_subnets
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "backend2-cont"
    container_port   = 8080
  }
  depends_on = [aws_lb_listener.app]
}

resource "aws_ecs_service" "backend3" {
  name            = "backend3-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.backend3.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = module.vpc.public_subnets
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "backend3-cont"
    container_port   = 8080
  }
  depends_on = [aws_lb_listener.app]
}

resource "aws_ecs_service" "backend4" {
  name            = "backend4-service"
  cluster         = aws_ecs_cluster.main.id
  task_definition = aws_ecs_task_definition.backend4.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  network_configuration {
    subnets          = module.vpc.public_subnets
    security_groups  = [aws_security_group.ecs.id]
    assign_public_ip = true
  }
  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = "backend4-cont"
    container_port   = 8080
  }
  depends_on = [aws_lb_listener.app]
}