{{
  config(
    materialized='view'
  )
}}

WITH src_events AS (
    SELECT DISTINCT event_type, date_load
    FROM {{ ref("base_sql_server_dbo__events") }}
    ),

renamed_casted AS (
    SELECT
          event_type
        , MD5(event_type) AS event_type_id
        , date_load
    FROM src_events
    )

SELECT * FROM renamed_casted