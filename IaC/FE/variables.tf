variable "aws_region" {
    description = "Default aws region"
    type = string
    default = "us-east-1"
}

variable "build_artifact_path" {
  description = "The path to the build artifact"
  type        = string
  default = "C:\\ORT\\Devops\\Obligatorio\\Obligatorio-Frontend\\dist\\apps\\catalog"
}

variable "bucket_name" {
    description = "Default bucket name"
    type = string
}

variable "environment" {
    description = "env name"
    type = string
}



