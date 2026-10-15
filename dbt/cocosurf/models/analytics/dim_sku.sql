select
    sku_id,
    product_id,
    sku_name,
    base_price,
    weight_grams,
    is_active
from {{ ref('stg_products_skus') }}