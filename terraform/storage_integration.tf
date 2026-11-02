resource "snowflake_storage_integration_aws" "cocosurf_s3" {
  name    = "COCOSURF_S3_INTEGRATION"
  enabled = true

  storage_provider = "S3"

  storage_allowed_locations = [
    "s3://cocosurf-gear-datalake/landed_data/"
  ]

  storage_aws_role_arn = aws_iam_role.snowflake_s3.arn

  depends_on = [
    snowflake_grant_privileges_to_account_role.sysadmin_create_integration
  ]
}

resource "snowflake_file_format_json" "cocosurf_json" {
  name     = "COCOSURF_JSON_FORMAT"
  database = snowflake_database.cocosurf_db.name
  schema   = snowflake_schema.raw.name
}
