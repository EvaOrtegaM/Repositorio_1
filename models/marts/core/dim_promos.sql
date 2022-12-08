with stg_promos as (

    select * from {{ ref('stg_sql_server_dbo_promos') }}

),

renamed_casted as (

    select

        promo_id,
        promo_description,    
        status_promo,
        discount,
        date_load

        from stg_promos

)

select * from renamed_casted