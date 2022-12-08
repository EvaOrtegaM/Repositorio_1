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
        a.state,
        a.country,
        sum(o.order_cost_usd) as total_sales_amount_usd,
        count(o.status_order) as total_number_sales
       
    FROM stg_addresses a
    left join stg_orders o using (address_id)
    GROUP BY a.state, a.country
    )
    
SELECT * FROM state_orders