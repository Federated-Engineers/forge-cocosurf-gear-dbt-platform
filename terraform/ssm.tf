resource "aws_ssm_parameter" "snowflake_org_name" {
  name        = "/production/cocosurf/snowflake/organization"
  description = "Snowflake organization name for Cocosurf"
  type        = "String"
  value       = "MQNSOWA"
}

resource "aws_ssm_parameter" "snowflake_account_name" {
  name        = "/production/cocosurf/snowflake/account"
  description = "Snowflake account identifier for Cocosurf"
  type        = "String"
  value       = "RX82601"
}

resource "aws_ssm_parameter" "snowflake_dbt_user" {
  name        = "/production/cocosurf/snowflake/dbt_user"
  description = "Snowflake dbt service username"
  type        = "String"
  value       = snowflake_legacy_service_user.cocosurf_dbt_svc.name
}

resource "aws_ssm_parameter" "snowflake_dbt_role" {
  name        = "/production/cocosurf/snowflake/dbt_role"
  description = "Snowflake role used by the Cocosurf dbt task"
  type        = "String"
  value       = snowflake_account_role.dbt_role.name
}

# resource "aws_ssm_parameter" "snowflake_dbt_user_password" {
#   name        = "/production/cocosurf/snowflake/dbt_user_password"
#   description = "Password for the COCOSURF_DBT_SVC Snowflake service user"
#   type        = "SecureString"

#   value_wo         = var.snowflake_password
#   value_wo_version = 1
# }
