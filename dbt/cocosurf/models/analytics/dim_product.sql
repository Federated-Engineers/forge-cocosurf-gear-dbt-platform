select distinct product_id
from {{ ref('stg_products_skus') }}
