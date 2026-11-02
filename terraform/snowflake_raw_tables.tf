resource "snowflake_table" "orders" {
  database = snowflake_database.cocosurf_db.name
  schema   = snowflake_schema.raw.name
  name     = "ORDERS"

  column {
    name = "RAW"
    type = "VARIANT"
  }
}

resource "snowflake_table" "customers" {
  database = snowflake_database.cocosurf_db.name
  schema   = snowflake_schema.raw.name
  name     = "CUSTOMERS"

  column {
    name = "RAW"
    type = "VARIANT"
  }
}

resource "snowflake_table" "order_items" {
  database = snowflake_database.cocosurf_db.name
  schema   = snowflake_schema.raw.name
  name     = "ORDER_ITEMS"

  column {
    name = "RAW"
    type = "VARIANT"
  }
}

resource "snowflake_table" "inventory" {
  database = snowflake_database.cocosurf_db.name
  schema   = snowflake_schema.raw.name
  name     = "INVENTORY"

  column {
    name = "RAW"
    type = "VARIANT"
  }
}

resource "snowflake_table" "products_skus" {
  database = snowflake_database.cocosurf_db.name
  schema   = snowflake_schema.raw.name
  name     = "PRODUCTS_SKUS"

  column {
    name = "RAW"
    type = "VARIANT"
  }
}
