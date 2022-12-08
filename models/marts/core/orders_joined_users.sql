with stg_users as (

    select * 
    from {{ ref('stg_sql_server_dbo_users') }}

),

stg_orders as (

    select
        user_id, 
        order_created_at_utc        
    from {{ ref('stg_sql_server_dbo_orders') }}

),

user_orders as (

    select
        user_id,
        min(order_created_at_utc) as first_order_date,
        max(order_created_at_utc) as most_recent_order_date,
        count(order_id) as number_of_orders

    from {{ ref('stg_sql_server_dbo_orders') }}

    group by 1

),

final as (

    select
        user_id,
        stg_users.first_name,
        stg_users.last_name,
        stg_users.email,
        stg_users.phone_number,
        user_orders.first_order_date,
        user_orders.most_recent_order_date,
        coalesce(user_orders.number_of_orders, 0) as number_of_orders,
        stg_users.user_created_at_utc,
        stg_users.user_updated_at_utc

    from stg_users

    left join user_orders using (user_id)

)

select * from final