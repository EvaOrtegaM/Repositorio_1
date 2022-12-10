WITH stg_events AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo_events') }}
    ),

renamed_casted AS (
    SELECT
         event_id
        ,event_type         
        ,page_url
        ,session_id
        ,user_id
        ,product_id
        ,order_id
        ,event_created_at_utc
        
    FROM stg_events
    )

SELECT * FROM renamed_casted