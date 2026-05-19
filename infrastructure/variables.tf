variable "team" {
  description = "The team responsible for the deployment"
  type        = string
  default = "cocosurf-gear"
}

variable "env" {
  description = "The environment for the deployment (e.g production, staging, dev)"
  type        = string
  default = "dev"
}

variable "ecr-use-case" {
  description = "The use case for the ECR repo"
  type = string
  default = "dbt"
}
