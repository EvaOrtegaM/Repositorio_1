with source as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

renamed as (

    select
        status,
        promo_id,
        discount,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed