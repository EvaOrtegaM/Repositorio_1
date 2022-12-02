
with base as (

    select * from {{ ref('base_orders_promo_id') }}

),

renamed_casted as (

    select
        order_id, 
        user_id,
        promotion_id,    
        address_id,
        created_at as order_created_at_utc,
        order_cost as order_cost_usd,                    
        shipping_cost as shipping_cost_usd,
        order_total as total_order_cost_usd,                
        shipping_service,
        status as status_order,
        delivered_at as delivered_at_utc,        
        estimated_delivery_at as estimated_delivery_at_utc,
        tracking_id,
        _fivetran_deleted,
        _fivetran_synced as date_load

    from base

)

select * from renamed_casted 