 {{ config(
    materialized = 'table'
) }}

WITH distinct_locations AS (

    SELECT DISTINCT
        country,
        city,
        state,
        postal_code,
        region

    FROM {{ ref('stg_orders') }}

)

SELECT
    ROW_NUMBER() OVER (
        ORDER BY country, state, city, postal_code, region
    ) AS location_key,
    country,
    city,
    state,
    postal_code,
    region

FROM distinct_locations
