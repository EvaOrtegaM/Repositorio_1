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

products_sold AS (
    SELECT
        
    p.product_id
    ,p.product_description
    ,p.price_usd
    ,sum(i.quantity) as total_products_sold    
    ,price_usd*total_products_sold as total_product_profit      


    FROM products p
    left join order_items i using (product_id)
    left join orders o using (order_id)
    GROUP BY product_id, product_description, price_usd
    )
    
SELECT * FROM products_sold