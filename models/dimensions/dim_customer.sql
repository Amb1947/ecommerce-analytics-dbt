{{ config(
    materialized = 'table'
) }}
WITH customer_base AS (
SELECT
    customer_id,
    customer_name,
    segment,
MIN(order_date) AS valid_from,
NULL::date AS valid_to,
TRUE AS is_current
FROM {{ ref('stg_orders') }}
GROUP BY
    customer_id,
    customer_name,
    segment
)
SELECT
    ROW_NUMBER() OVER (
        ORDER BY customer_id
    ) AS customer_sk,
    customer_id,
    customer_name,
    segment,
    valid_from,
    valid_to,
    is_current
FROM customer_base