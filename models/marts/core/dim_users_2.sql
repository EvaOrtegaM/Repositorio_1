with users as (

    select * 
    from {{ ref('stg_sql_server_dbo_users') }}

),

orders as (

    select
        user_id 
        created_at_utc,        
    from {{ ref('stg_sql_server_dbo_orders') }}

),

user_orders as (

    select
        user_id,
        min(created_at_utc) as first_order_date,
        max(created_at_utc) as most_recent_order_date,
        count(order_id) as number_of_orders

    from {{ ref('stg_sql_server_dbo_orders') }}

    group by 1

),

final as (

    select
        user_id,
        users.first_name,
        user_orders.last_name,
        user_orders.first_order_date,
        users.first_order_date,
        user_orders.most_recent_order_date,
        coalesce(user_orders.number_of_orders, 0) as number_of_orders

    from users

    left join user_orders using (user_id)

)

select * from final