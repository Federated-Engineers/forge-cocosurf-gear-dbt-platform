select
    f.value:order_id::string as order_id,
    f.value:customer_id::string as customer_id,
    f.value:order_status::string as order_status,
    f.value:total_tax_amount::number as total_tax_amount,
    f.value:order_total::number as order_total,
    f.value:placed_at::timestamp as placed_at
from {{ source('raw', 'orders') }},
    lateral flatten(input => raw) as f
