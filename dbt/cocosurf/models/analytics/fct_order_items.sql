
select
    order_item_id,
    order_id,
    sku_id,
    quantity,
    unit_price_sold,
    discount_amount,
    (quantity * unit_price_sold) - discount_amount as net_item_amount
from {{ ref('stg_order_items') }}
