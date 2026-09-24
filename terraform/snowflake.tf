resource "snowflake_warehouse" "cocosurf_wh" {
  name                = "COCOSURF_WH"
  warehouse_size      = "XSMALL"
  auto_suspend        = 300
  auto_resume         = true
  initially_suspended = true
}

resource "snowflake_database" "cocosurf_db" {
  name = "COCOSURF_DB"
}

resource "snowflake_schema" "raw" {
  database = snowflake_database.cocosurf_db.name
  name     = "RAW"
}

resource "snowflake_schema" "staging" {
  database = snowflake_database.cocosurf_db.name
  name     = "STAGING"
}

resource "snowflake_schema" "analytics" {
  database = snowflake_database.cocosurf_db.name
  name     = "ANALYTICS"
}

resource "snowflake_account_role" "dbt_role" {
  provider = snowflake.accountadmin
  name     = "DBT_ROLE"
}

resource "snowflake_account_role" "analytics_role" {
  provider = snowflake.accountadmin
  name     = "ANALYTICS_ROLE"
}

resource "snowflake_grant_account_role" "dbt_to_sysadmin" {
  role_name        = snowflake_account_role.dbt_role.name
  parent_role_name = "SYSADMIN"
}

resource "snowflake_grant_account_role" "analytics_to_sysadmin" {
  role_name        = snowflake_account_role.analytics_role.name
  parent_role_name = "SYSADMIN"
}

resource "snowflake_grant_privileges_to_account_role" "dbt_warehouse_usage" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.dbt_role.name

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.cocosurf_wh.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "analytics_warehouse_usage" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.analytics_role.name

  on_account_object {
    object_type = "WAREHOUSE"
    object_name = snowflake_warehouse.cocosurf_wh.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_database_usage" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.dbt_role.name

  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.cocosurf_db.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_raw_schema_usage" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.dbt_role.name

  on_schema {
    schema_name = "\"${snowflake_database.cocosurf_db.name}\".\"${snowflake_schema.raw.name}\""
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_staging_schema_usage" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.dbt_role.name

  on_schema {
    schema_name = "\"${snowflake_database.cocosurf_db.name}\".\"${snowflake_schema.staging.name}\""
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_analytics_schema_usage" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.dbt_role.name

  on_schema {
    schema_name = "\"${snowflake_database.cocosurf_db.name}\".\"${snowflake_schema.analytics.name}\""
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_raw_tables" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.dbt_role.name

  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.raw.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_raw_future_tables" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.dbt_role.name

  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.raw.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_staging_tables" {
  privileges        = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES"]
  account_role_name = snowflake_account_role.dbt_role.name

  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.staging.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_staging_future_tables" {
  privileges        = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES"]
  account_role_name = snowflake_account_role.dbt_role.name

  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.staging.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_staging_views" {
  privileges        = ["SELECT", "REFERENCES"]
  account_role_name = snowflake_account_role.dbt_role.name

  on_schema_object {
    all {
      object_type_plural = "VIEWS"
      in_schema          = snowflake_schema.staging.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_staging_future_views" {
  privileges        = ["SELECT", "REFERENCES"]
  account_role_name = snowflake_account_role.dbt_role.name

  on_schema_object {
    future {
      object_type_plural = "VIEWS"
      in_schema          = snowflake_schema.staging.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_analytics_tables" {
  privileges        = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES"]
  account_role_name = snowflake_account_role.dbt_role.name

  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.analytics.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_analytics_future_tables" {
  privileges        = ["SELECT", "INSERT", "UPDATE", "DELETE", "TRUNCATE", "REFERENCES"]
  account_role_name = snowflake_account_role.dbt_role.name

  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.analytics.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_analytics_views" {
  privileges        = ["SELECT", "REFERENCES"]
  account_role_name = snowflake_account_role.dbt_role.name

  on_schema_object {
    all {
      object_type_plural = "VIEWS"
      in_schema          = snowflake_schema.analytics.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_analytics_future_views" {
  privileges        = ["SELECT", "REFERENCES"]
  account_role_name = snowflake_account_role.dbt_role.name

  on_schema_object {
    future {
      object_type_plural = "VIEWS"
      in_schema          = snowflake_schema.analytics.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_staging_create" {
  privileges        = ["CREATE TABLE", "CREATE VIEW"]
  account_role_name = snowflake_account_role.dbt_role.name

  on_schema {
    schema_name = snowflake_schema.staging.fully_qualified_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "dbt_analytics_create" {
  privileges        = ["CREATE TABLE", "CREATE VIEW"]
  account_role_name = snowflake_account_role.dbt_role.name

  on_schema {
    schema_name = snowflake_schema.analytics.fully_qualified_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "analytics_database_usage" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.analytics_role.name

  on_account_object {
    object_type = "DATABASE"
    object_name = snowflake_database.cocosurf_db.name
  }
}

resource "snowflake_grant_privileges_to_account_role" "analytics_schema_usage" {
  privileges        = ["USAGE"]
  account_role_name = snowflake_account_role.analytics_role.name

  on_schema {
    schema_name = snowflake_schema.analytics.fully_qualified_name
  }
}

resource "snowflake_grant_privileges_to_account_role" "analytics_select_tables" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.analytics_role.name

  on_schema_object {
    all {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.analytics.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "analytics_future_tables" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.analytics_role.name

  on_schema_object {
    future {
      object_type_plural = "TABLES"
      in_schema          = snowflake_schema.analytics.fully_qualified_name
    }
  }
}
resource "snowflake_grant_privileges_to_account_role" "analytics_select_views" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.analytics_role.name

  on_schema_object {
    all {
      object_type_plural = "VIEWS"
      in_schema          = snowflake_schema.analytics.fully_qualified_name
    }
  }
}

resource "snowflake_grant_privileges_to_account_role" "analytics_future_views" {
  privileges        = ["SELECT"]
  account_role_name = snowflake_account_role.analytics_role.name

  on_schema_object {
    future {
      object_type_plural = "VIEWS"
      in_schema          = snowflake_schema.analytics.fully_qualified_name
    }
  }
}
