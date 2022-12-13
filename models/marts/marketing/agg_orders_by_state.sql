WITH addresses AS (
    SELECT * 
    FROM {{ ref('dim_addresses') }}
    ),

orders AS (
    SELECT * 
    FROM {{ ref('fct_orders') }}
    ),    

state_orders AS (
    SELECT
        a.state
        ,a.country
        ,sum(o.order_cost_usd) as total_sales_usd
        ,sum(case when o.status_order = 'delivered' then 1 else 0 end) as total_orders_delivered
        ,sum(case when o.status_order = 'shipped' then 1 else 0 end) as total_orders_shipped
        ,sum(case when o.status_order = 'preparing' then 1 else 0 end) as total_orders_preparing

    FROM addresses a
    left join orders o using (address_id)
    GROUP BY a.state, a.country
    )
    
SELECT * FROM state_orders