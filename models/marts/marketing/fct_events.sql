WITH stg_events AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo_events') }}
    ),

renamed_casted AS (
    SELECT
         event_id
        ,page_url
        ,event_type
        ,user_id
        ,product_id
        ,session_id
        ,event_created_at_utc
        ,order_id
        ,date_load
    FROM stg_events
    )

SELECT * FROM renamed_casted