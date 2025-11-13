{{
  config(
    materialized='incremental',
    unique_key = 'order_id'
  )
}}

WITH src_order_items AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'order_items') }}

    {% if is_incremental() %}

        where _fivetran_synced > (select max(date_load) from {{ this }})

    {% endif %}

),

renamed_casted AS (
    SELECT
          order_id
        , product_id
        , quantity
        , _fivetran_synced AS date_load
    FROM src_order_items
    )

SELECT * FROM renamed_casted

