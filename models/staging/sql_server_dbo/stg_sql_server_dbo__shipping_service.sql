{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT DISTINCT shipping_service, date_load
    FROM {{ ref("base_sql_server_dbo__orders") }}
    ),

renamed_casted AS (
    SELECT
          COALESCE(NULLIF(shipping_service, ''), 'no_shipping') AS shipping_service
        , MD5(shipping_service) AS shipping_service_id
        , date_load
    FROM src_orders
    )

SELECT * FROM renamed_casted