select
    extract(year from order_date)::integer as year,
    'Q' || extract(quarter from order_date)::integer as quarter,
    date_trunc('month', order_date)::date as month,
    sum(sales) as total_revenue
from {{ ref('stg_orders') }}
group by
    extract(year from order_date),
    extract(quarter from order_date),
    date_trunc('month', order_date)