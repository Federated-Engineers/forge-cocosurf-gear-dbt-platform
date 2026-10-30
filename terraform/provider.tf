terraform {
  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "~> 2.0"
    }
  }

  # required_version = ">= 1.14.4"
}

provider "snowflake" {
  alias = "accountadmin"
  role  = "ACCOUNTADMIN"

  experimental_features_enabled = [
    "USER_ENABLE_DEFAULT_WORKLOAD_IDENTITY"
  ]
}

provider "snowflake" {
  role = "SYSADMIN"

  preview_features_enabled = [
    "snowflake_external_table_resource",
    "snowflake_table_resource"
  ]

  experimental_features_enabled = [
    "USER_ENABLE_DEFAULT_WORKLOAD_IDENTITY"
  ]
}
