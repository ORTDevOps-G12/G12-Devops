variable "aws_region" {
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nombre del proyecto"
  default     = "nombre"
}

variable "cluster_name" {
  description = "The cluster name"
}

variable "products-service-backend-name" {
  description = "Name of BE service"
}

variable "products-service-docker-image" {
  description = "Docker image for products service backend"
}

variable "payments-service-backend-name" {
  description = "Name of BE service"
}

variable "payments-service-docker-image" {
  description = "Docker image for payments service backend"
}

variable "shipping-service-backend-name" {
  description = "Name of BE service"
}

variable "shipping-service-docker-image" {
  description = "Docker image for shipping service backend"
}

variable "orders-service-backend-name" {
  description = "Name of BE service"
}

variable "orders-service-docker-image" {
  description = "Docker image for orders service backend"
}

variable "labrole_arn" {
  description = "AWS role to create tasks"
}

variable "ecs_services" {
  type    = string
  default =  "tsting-products-service,tsting-payments-service,tsting-shipping-service,tsting-orders-service"
}

variable "s3-backup-bucket" {
  description = "S3 para backup"
}

variable "docker_username" {
  description = "dokcer user"
}

variable "docker_password" {
  description = "dokcer pwd"
}