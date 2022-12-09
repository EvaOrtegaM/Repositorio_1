WITH stg_addresses AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo_addresses') }}
    ),

stg_orders AS (
    SELECT * 
    FROM {{ ref('stg_sql_server_dbo_orders') }}
    ),    

state_orders AS (
    SELECT
        a.state
        ,a.country
        ,sum(o.order_cost_usd) as total_sales_amount_usd
        ,sum(case when o.status_order = 'delivered' then 1 else 0 end) as total_orders_delivered
        ,sum(case when o.status_order = 'shipped' then 1 else 0 end) as total_orders_shipped
        ,sum(case when o.status_order = 'preparing' then 1 else 0 end) as total_orders_preparing

    FROM stg_addresses a
    left join stg_orders o using (address_id)
    GROUP BY a.state, a.country
    )
    
SELECT * FROM state_orders