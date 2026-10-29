# terraform {
#   required_providers {
#     snowflake = {
#       source  = "snowflakedb/snowflake"
#       version = "~> 2.0"
#     }
#   }

#   #required_version = ">= 1.14.4"
# }

# # ACCOUNTADMIN provider
# # Used only for account-level role creation
# # provider "snowflake" {
# #   alias             = "accountadmin"
# #   account_name      = var.snowflake_account_name
# #   organization_name = var.snowflake_organization_name
# #   user              = var.snowflake_user
# #   password          = var.snowflake_password
# #   role              = "ACCOUNTADMIN"
# # }

# # # SYSADMIN provider
# # # Used for the Cocosurf data environment
# # provider "snowflake" {
# #   account_name      = var.snowflake_account_name
# #   organization_name = var.snowflake_organization_name
# #   user              = var.snowflake_user
# #   password          = var.snowflake_password
# #   role              = "SYSADMIN"



# provider "snowflake" {
#   alias = "accountadmin"
#   role  = "ACCOUNTADMIN"
# }
# provider "snowflake" {
#   role = "SYSADMIN"

#   preview_features_enabled = [
#     "snowflake_external_table_resource",
#     "snowflake_table_resource"
#   ]

# }



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
