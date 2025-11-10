{{
  config(
    materialized='view'
  )
}}

WITH src_addresses AS (
    SELECT * 
    FROM {{ ref("base_sql_server_dbo__addresses") }}
    ),

renamed_casted AS (
    SELECT
        MD5(CONCAT(country, state, address)) AS zipcode_id
        ,country
        ,state
        ,address
        , _fivetran_synced AS date_load
    FROM src_addresses
    )

SELECT * FROM renamed_casted