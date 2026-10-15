select
    f.value:inventory_id::string as inventory_id,
    f.value:sku_id::string as sku_id,
    f.value:warehouse_id::string as warehouse_id,
    f.value:quantity_on_hand::number as quantity_on_hand,
    f.value:quantity_reserved::number as quantity_reserved,
    f.value:last_restock_date::timestamp as last_restock_date
from {{ source('raw', 'inventory') }},
lateral flatten(input => raw) f
