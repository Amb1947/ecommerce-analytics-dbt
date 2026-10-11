{{ config(
    materialized = 'table'
) }}
WITH order_base AS (

SELECT
    row_id,
    order_id,
    customer_id,
    product_id,
    order_date,
    ship_date,
    ship_mode,
    sales,
country,
city,
state,
postal_code,
region
FROM {{ ref('stg_orders') }}
)
SELECT
    row_id,
    order_id,
    dim_customer.customer_sk,
    dim_product.product_sk,
    dim_date.date_key AS order_date_key,
    ship_date_dim.date_key AS ship_date_key,
    dim_location.location_key AS location_key,
    ship_mode,
    sales,
     ship_date - order_date AS shipping_days
FROM order_base
LEFT JOIN {{ ref('dim_customer') }} AS dim_customer
    ON order_base.customer_id = dim_customer.customer_id
LEFT JOIN {{ ref('dim_product') }} AS dim_product
    ON order_base.product_id = dim_product.product_id

LEFT JOIN {{ ref('dim_date') }} AS dim_date
    ON order_base.order_date = dim_date.date_day

LEFT JOIN {{ ref('dim_date') }} AS ship_date_dim
    ON order_base.ship_date = ship_date_dim.date_day

LEFT JOIN {{ ref('dim_location') }} AS dim_location
    ON order_base.country = dim_location.country
    AND order_base.city = dim_location.city
    AND order_base.state = dim_location.state
    AND order_base.postal_code = dim_location.postal_code
    AND order_base.region = dim_location.region
