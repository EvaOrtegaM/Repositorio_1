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
        , created_at
        , order_cost_usd
        , shipping_cost_usd
        , total_order_cost_usd
        , tracking_id
        , shipping_service
        , estimated_delivery_at
        , delivered_at
		, DATEDIFF(day, created_at, delivered_at) AS days_to_deliver
        , status_order
        , date_load
    FROM stg_orders
    )

SELECT * FROM renamed_casted