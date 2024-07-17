variable "aws_region" {
  description = "The AWS region to deploy to"
  type = string
  default     = "us-east-1"
}

variable "vpc_name" {
  description = ""
  type = string
  default = "vpc_name"
}

variable "security_group_name" {
  description = ""
  type = string
  default = "security_group_name"
}

variable "environment_name" {
  description = ""
  type = string
  default = "environment_name"
}

variable "labrole_arn" {
  description = "rol de aws"
  type = string
  default = "arn:aws:iam::576955172276:role/LabRole"
}

variable "backend_image1" {
  description = "The Docker image to deploy"
  type = string
  default = "nconan/products-service-example:dev1"
}

variable "backend_image2" {
  description = "Docker image for backend service 2"
  type = string
  default = "nconan/payments-service-example:dev1"
}

variable "backend_image3" {
  description = "Docker image for backend service 3"
  type = string
  default = "nconan/shipping-service-example:dev1"
}

variable "backend_image4" {
  description = "Docker image for backend service 4"
  type = string
  default = "nconan/orders-service-example:dev1"
}

variable "cluster_name" {
  description = ""
  type = string
  default = "cluster_name"
}

variable "load_balancer_name" {
  description = ""
  type = string
  default = "load_balancer_name"
}

variable "target_group_name" {
  description = ""
  type = string
  default = "target_group_name"
}



