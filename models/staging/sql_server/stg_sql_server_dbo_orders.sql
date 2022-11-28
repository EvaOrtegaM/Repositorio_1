with source as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed_casted as (

    select
        shipping_service,
        shipping_cost_usd,
        status,
        order_id,
        estimated_delivery_at,
        user_id,
        order_total,
        address_id,
        created_at,
        order_cost_usd,
        promo_id,
        tracking_id,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed_casted 