select
    region,
    sum(sales) as total_revenue
from {{ ref('stg_orders') }}
group by region