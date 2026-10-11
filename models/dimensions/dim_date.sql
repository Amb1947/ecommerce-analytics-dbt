{{ config(
    materialized = 'table'
) }}

WITH date_spine AS (

    SELECT
        generate_series(
            (
                SELECT LEAST(
                    MIN(order_date),
                    MIN(ship_date)
                )
                FROM {{ ref('stg_orders') }}
            ),
            (
                SELECT GREATEST(
                    MAX(order_date),
                    MAX(ship_date)
                )
                FROM {{ ref('stg_orders') }}
            ),
            INTERVAL '1 day'
        )::date AS date_day

)

SELECT
    TO_CHAR(date_day, 'YYYYMMDD')::integer AS date_key,
    date_day,
    EXTRACT(YEAR FROM date_day)::integer AS year,
    EXTRACT(QUARTER FROM date_day)::integer AS quarter,
    EXTRACT(MONTH FROM date_day)::integer AS month,
    EXTRACT(DOW FROM date_day)::integer AS day_of_week,
    CASE
        WHEN EXTRACT(DOW FROM date_day)::integer IN (0, 6)
            THEN TRUE
        ELSE FALSE
    END AS is_weekend

FROM date_spine