select
    f.value:sku_id::string as sku_id,
    f.value:product_id::string as product_id,
    f.value:sku_name::string as sku_name,
    f.value:base_price::number as base_price,
    f.value:weight_grams::number as weight_grams,
    f.value:is_active::boolean as is_active
from {{ source('raw', 'products_skus') }},
lateral flatten(input => raw) f