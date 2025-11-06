{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'orders') }}
    ),

renamed_casted AS (
    SELECT
          created_at
        , delivered_at
        , estimated_delivery_at
        , order_cost
        , order_id
        , order_total
        , MD5(LOWER(REPLACE(REPLACE(promo_id, '-', '_'), ' ', '_'))) AS promo_id
        , shipping_cost
        , shipping_service
        , status
        , tracking_id
        , user_id
        , CONVERT_TIMEZONE ('UTC',_fivetran_synced ) AS date_load
    FROM src_orders
    )

SELECT * FROM renamed_casted