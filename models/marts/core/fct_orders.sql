WITH stg_orders AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo_orders') }}
),

renamed_casted AS (
    SELECT
        order_id 
        , user_id 
        , promo_id
        , address_id    
        , order_created_at_utc
        , order_cost_usd
        , shipping_cost_usd
        , total_order_cost_usd
        , shipping_service
        , status_order        
        , estimated_delivery_at_utc
        , delivered_at_utc
		, DATEDIFF(day, order_created_at_utc, delivered_at_utc) AS days_to_deliver
        , tracking_id
        , date_load

    FROM stg_orders
    )

SELECT * FROM renamed_casted