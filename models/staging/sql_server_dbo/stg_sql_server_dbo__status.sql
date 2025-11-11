{{
  config(
    materialized='view'
  )
}}

WITH src_orders AS (
    SELECT DISTINCT status, date_load
    FROM {{ ref("base_sql_server_dbo__orders") }}
    ),

renamed_casted AS (
    SELECT
          status
        , MD5(status) AS status_id
        , date_load
    FROM src_orders
    )

SELECT * FROM renamed_casted