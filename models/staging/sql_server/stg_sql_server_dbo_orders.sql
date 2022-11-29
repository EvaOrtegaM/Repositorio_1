with source as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed_casted as (

    select
        shipping_service,
        shipping_cost as shipping_cost_usd,
        status as status_order,
        order_id,
        estimated_delivery_at as estimated_delivery_at_utc,
        user_id,
        order_total as total_order_cost_usd,
        address_id,
        created_at as created_at_utc,
        delivered_at as delivered_at_utc,
        order_cost as order_cost_usd,
        promo_id,
        tracking_id,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed_casted 