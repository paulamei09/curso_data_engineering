{{
  config(
    materialized='view'
  )
}}

WITH src_users AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'users') }}
    ),

renamed_casted AS (
    SELECT
          address_id
        , created_at
        , email
        , coalesce (regexp_like(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$')= true,false) as is_valid_email_address
        , first_name
        , last_name
        , phone_number
        , total_orders
        , updated_at
        , user_id
        , CONVERT_TIMEZONE ('UTC',_fivetran_synced ) AS date_load
    FROM src_users
    )

SELECT * FROM renamed_casted