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

variable "snowflake_dbt_password" {
  description = "Password for the COCOSURF_DBT_SVC Snowflake service user."
  type        = string
  sensitive   = true
}
