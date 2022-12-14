 with users as (

    select * 
    from {{ ref('dim_users') }}

),

orders as (

    select *      
    from {{ ref('fct_orders') }}

),

order_items as (

    select *     
    from {{ ref('dim_order_items') }}

),


user_orders as (

    select
        user_id,
        min(order_created_at_utc) as first_order_date,
        max(order_created_at_utc) as most_recent_order_date,
        count(order_id) as number_of_orders,
        sum (order_cost_usd) as total_order_costs_usd,
        sum (shipping_cost_usd) as total_shipping_costs_usd,
        sum (total_order_cost_usd) as total_costs_usd             
        

    from {{ ref('fct_orders') }}

    group by 1

),


items_per_order as (

    select
        user_id,
        count(product_id) as total_different_products,
        sum(quantity) as total_products_quantity
        
    from orders
    left join order_items using (order_id)

    group by user_id

),


final as (

    select
        user_id,
        users.first_name,
        users.last_name,
        users.email,
        user_orders.first_order_date,
        user_orders.most_recent_order_date,
        coalesce(user_orders.number_of_orders, 0) as number_of_orders,
        users.user_created_at_utc,
        users.user_updated_at_utc,
        user_orders.total_order_costs_usd,
        user_orders.total_shipping_costs_usd,
        user_orders.total_costs_usd, 
        items_per_order.total_different_products,
        items_per_order.total_products_quantity                

    from users
    left join user_orders using (user_id)
    left join items_per_order using (user_id)

)

select * from final