select
    category,
    sum(sales) as total_revenue
from {{ ref('stg_orders') }}
where order_year = (
    select max(order_year)
    from {{ ref('stg_orders') }}
)
group by category
order by total_revenue asc