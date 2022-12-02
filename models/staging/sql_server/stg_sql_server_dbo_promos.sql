
with base_promos as (

    select * from {{ ref('base_promos_promo_id') }}

),

renamed as (

    select

        promotion_id,
        promo_name,
        status as status_promo,
        discount,
        _fivetran_deleted,
        _fivetran_synced as date_load

    from base_promos

)

select * from renamed