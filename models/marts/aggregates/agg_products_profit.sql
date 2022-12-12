WITH products AS (
    SELECT * 
    FROM {{ ref('dim_products') }}
    ),

order_items AS (
    SELECT * 
    FROM {{ ref('dim_order_items') }}
    ),

orders AS (
    SELECT * 
    FROM {{ ref('fct_orders') }}
    ),    

dim_date AS (
    SELECT * 
    FROM {{ ref('dim_date') }}
    ),    


products_sold AS (
    SELECT
        
    p.product_id
    ,o.order_id
    ,p.product_description
    ,p.price_usd
    ,sum(i.quantity) as total_products_sold    
    ,price_usd*total_products_sold as total_product_profit_usd      
    ,to_date( o.order_created_at_utc) as order_date

    FROM products p
    left join order_items i using (product_id)
    left join orders o using (order_id)

    GROUP BY product_id, product_description, price_usd, order_date, o.order_id
    order by order_date desc
    ),
    

products_month AS (
    SELECT
        
    product_id
    ,p.product_description
    ,p.price_usd
    ,sum(p.total_products_sold) as total_sold_per_product
    ,sum(p.total_product_profit_usd) as total_profit_per_product
    ,d.month

    FROM products_sold p
    left join dim_date d on p.order_date = d.date_day
    
    GROUP BY  month ,product_id, product_description, price_usd
    )
    
SELECT * FROM products_month