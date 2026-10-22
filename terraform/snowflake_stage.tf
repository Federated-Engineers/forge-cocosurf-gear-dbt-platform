resource "snowflake_stage_external_s3" "cocosurf_raw" {
  name     = "COCOSURF_RAW_STAGE"
  database = "COCOSURF_DB"
  schema   = "RAW"

  url = "s3://cocosurf-gear-datalake/landed_data/"


  storage_integration = snowflake_storage_integration_aws.cocosurf_s3.name
}
