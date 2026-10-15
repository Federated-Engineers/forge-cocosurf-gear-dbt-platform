select
    f.value:customer_id::string as customer_id,
    f.value:email::string as email,
    f.value:first_name::string as first_name,
    f.value:last_name::string as last_name,
    f.value:customer_segment::string as customer_segment,
    f.value:default_shipping_address_id::string as default_shipping_address_id,
    f.value:created_at::timestamp as created_at
from {{ source('raw', 'customers') }},
lateral flatten(input => raw) f