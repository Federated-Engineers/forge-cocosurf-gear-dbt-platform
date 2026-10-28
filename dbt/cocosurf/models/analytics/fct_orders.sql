with item_totals as (
    select
        order_id,
        sum(net_item_amount) as net_item_amount
    from {{ ref('fct_order_items') }}
    group by order_id
)

select
    o.order_id,
    o.customer_id,
    o.order_status,
    o.total_tax_amount,
    o.order_total,
    o.placed_at,
    coalesce(i.net_item_amount, 0) as net_item_amount,
    coalesce(i.net_item_amount, 0) + o.total_tax_amount as calculated_revenue
from {{ ref('stg_orders') }} as o
left join item_totals as i
    on o.order_id = i.order_id
