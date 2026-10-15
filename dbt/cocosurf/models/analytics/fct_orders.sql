select
    o.order_id,
    o.customer_id,
    o.order_status,
    o.total_tax_amount,
    o.order_total,
    coalesce(i.net_item_amount, 0) as net_item_amount,
    coalesce(i.net_item_amount, 0) + o.total_tax_amount as calculated_revenue,
    o.placed_at
from {{ ref('stg_orders') }} o
left join (
    select
        order_id,
        sum(net_item_amount) as net_item_amount
    from {{ ref('fct_order_items') }}
    group by order_id
) i
    on o.order_id = i.order_id