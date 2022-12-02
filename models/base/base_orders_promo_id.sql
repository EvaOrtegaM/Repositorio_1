with source as (

    select * from {{ source('sql_server_dbo', 'orders') }}

),

renamed_casted as (

    select
        order_id, 
        user_id,
        md5(promo_id::varchar) as promotion_id,
        case when promo_id ='' then 'No promotion' 
        else promo_id
        end as promo_name,
        promo_id    
        address_id,
        created_at,
        order_cost,                    
        shipping_cost,
        order_total,                
        shipping_service,
        status,
        delivered_at,        
        estimated_delivery_at,
        tracking_id,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed_casted 