select
    customer_id,
    email,
    first_name,
    last_name,
    customer_segment,
    default_shipping_address_id,
    created_at
from {{ ref('stg_customers') }}