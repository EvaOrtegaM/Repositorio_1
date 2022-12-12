
WITH src_events AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'events') }}
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
        ,created_at as event_created_at_utc
        ,_fivetran_deleted as deletion_date
    FROM src_events
    )

SELECT * FROM renamed_casted

