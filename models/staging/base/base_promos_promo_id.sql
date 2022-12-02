with source as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

base_orders as (

    select promotion_id, promo_name from {{ ref('base_orders_promo_id') }}

),

final as (

    select

        base_orders.promotion_id,
        base_orders.promo_name,
        source.status,
        source.discount,
        source._fivetran_deleted,
        source._fivetran_synced

    from source 
    left join base_orders using (promo_id)

)

select * from final