select
    inventory_id,
    sku_id,
    warehouse_id,
    quantity_on_hand,
    quantity_reserved,
    last_restock_date,
    quantity_on_hand - quantity_reserved as available_to_promise
from {{ ref('stg_inventory') }}
