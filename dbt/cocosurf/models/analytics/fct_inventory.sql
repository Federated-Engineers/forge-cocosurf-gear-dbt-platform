select
    inventory_id,
    sku_id,
    warehouse_id,
    quantity_on_hand,
    quantity_reserved,
    quantity_on_hand - quantity_reserved as available_to_promise,
    last_restock_date
from {{ ref('stg_inventory') }}