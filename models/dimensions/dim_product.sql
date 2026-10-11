{{ config(
    materialized = 'table'
) }}
WITH latest_product AS (

     SELECT
        product_id,
        product_name,
        category,
        sub_category,

        ROW_NUMBER() OVER (
            PARTITION BY product_id
            ORDER BY order_date DESC, row_id DESC
        ) AS rn

    FROM {{ ref('stg_orders') }}
)
SELECT
    ROW_NUMBER() OVER (
        ORDER BY product_id
    ) AS product_sk,
    product_id,
    product_name,
    category,
    sub_category
FROM latest_product
WHERE rn = 1
