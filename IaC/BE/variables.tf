variable "aws_region" {
  description = "The AWS region to deploy to"
  default     = "us-east-1"
}

variable "project_name" {
  description = "Nombre del proyecto"
  default     = "nombre"
}

variable "products-service-docker-image" {
  description = "Docker image for products service backend"
}

variable "payments-service-docker-image" {
  description = "Docker image for payments service backend"
}

variable "shipping-service-docker-image" {
  description = "Docker image for shipping service backend"
}

variable "orders-service-docker-image" {
  description = "Docker image for orders service backend"
}

variable "labrole_arn" {
  description = "AWS role to create tasks"
}
