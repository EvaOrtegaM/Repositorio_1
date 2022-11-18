with source as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

pedidos as (

    select
        shipping_service,
        shipping_cost,
        status,
        order_id,
        estimated_delivery_at,
        user_id,
        order_total,
        address_id,
        created_at,
        order_cost,
        promo_id,
        tracking_id,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from pedidos