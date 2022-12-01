with stg_promos as (

    select * from {{ ref('stg_sql_server_dbo_promos') }}

),

renamed_casted as (

    select

        status_promo,
        promo_id,
        discount,
        _fivetran_deleted,
        _fivetran_synced

        from stg_promos

)

select * from renamed_casted