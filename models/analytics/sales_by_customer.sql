select
    customer_id,
    customer_name,
    sum(sales) as total_revenue
from {{ ref('stg_orders') }}
group by
    customer_id,
    customer_name