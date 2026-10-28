resource "snowflake_table" "orders" {
  database = "COCOSURF_DB"
  schema   = "RAW"
  name     = "ORDERS"

  column {
    name = "RAW"
    type = "VARIANT"
  }
}

resource "snowflake_table" "customers" {
  database = "COCOSURF_DB"
  schema   = "RAW"
  name     = "CUSTOMERS"

  column {
    name = "RAW"
    type = "VARIANT"
  }
}

resource "snowflake_table" "order_items" {
  database = "COCOSURF_DB"
  schema   = "RAW"
  name     = "ORDER_ITEMS"

  column {
    name = "RAW"
    type = "VARIANT"
  }
}

resource "snowflake_table" "inventory" {
  database = "COCOSURF_DB"
  schema   = "RAW"
  name     = "INVENTORY"

  column {
    name = "RAW"
    type = "VARIANT"
  }
}

resource "snowflake_table" "products_skus" {
  database = "COCOSURF_DB"
  schema   = "RAW"
  name     = "PRODUCTS_SKUS"

  column {
    name = "RAW"
    type = "VARIANT"
  }
}