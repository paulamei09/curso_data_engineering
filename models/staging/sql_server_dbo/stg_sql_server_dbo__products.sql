{{
  config(
    materialized='view'
  )
}}

WITH src_products AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'products') }}
    ),

renamed_casted AS (
    SELECT
          product_id
        , price as unit_price_usd
        , name as product_name
        , inventory
        , CONVERT_TIMEZONE ('UTC',_fivetran_synced ) AS date_load
    FROM src_products
    )

SELECT * FROM renamed_casted