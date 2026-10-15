select
    f.value:order_item_id::string as order_item_id,
    f.value:order_id::string as order_id,
    f.value:sku_id::string as sku_id,
    f.value:quantity::number as quantity,
    f.value:unit_price_sold::number as unit_price_sold,
    f.value:discount_amount::number as discount_amount
from {{ source('raw', 'order_items') }},
    lateral flatten(input => raw) as f
