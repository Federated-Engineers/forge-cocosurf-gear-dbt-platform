terraform {
  required_providers {
    snowflake = {
      source  = "snowflakedb/snowflake"
      version = "~> 2.0"
    }
  }

  required_version = ">= 1.6.0"
}

# ACCOUNTADMIN provider
# Used only for account-level role creation
provider "snowflake" {
  alias             = "accountadmin"
  account_name      = var.snowflake_account
  organization_name = var.snowflake_organization
  user              = var.snowflake_user
  password          = var.snowflake_password
  role              = "ACCOUNTADMIN"
}

# SYSADMIN provider
# Used for the Cocosurf data environment
provider "snowflake" {
  account_name      = var.snowflake_account
  organization_name = var.snowflake_organization
  user              = var.snowflake_user
  password          = var.snowflake_password
  role              = "SYSADMIN"
}
