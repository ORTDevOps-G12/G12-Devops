variable "cluster_name" {
  description = "The cluster name"
}

variable "object_name" {
  description = "Name to add in task name"
}

variable "labrole_arn" {
  description = "AWS role to create tasks"
}

variable "docker-image" {
  description = "Docker image for products service backend"
}

variable "subnets"{
  description = "value"
}