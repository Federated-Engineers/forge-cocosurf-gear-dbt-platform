variable "snowflake_account" {
  type      = string
  sensitive = true
}

variable "snowflake_user" {
  type = string
}

variable "snowflake_password" {
  type      = string
  sensitive = true
}

variable "snowflake_organization" {
  type = string
}

# variable "ecs_subnet_ids" {
#   description = "Company-managed private subnet IDs for the Cocosurf ECS Fargate task."
#   type        = list(string)
# }

# variable "ecs_security_group_id" {
#   description = "Company-managed security group ID for the Cocosurf ECS Fargate task."
#   type        = string
# }

# variable "airflow_aws_role_arn" {
#   description = "Company-managed IAM role ARN used by Airflow to launch and monitor Cocosurf ECS tasks."
#   type        = string
# }

variable "snowflake_dbt_password" {
  description = "Password for the COCOSURF_DBT_SVC Snowflake service user."
  type        = string
  sensitive   = true
}
