with stg_addresses as (

    select * from {{ ref('stg_sql_server_dbo_addresses') }}

),

renamed_casted as (

    select

        address,
        state,
        country,
        address_id,
        zipcode,
        _fivetran_deleted,
        _fivetran_synced

    from stg_addresses

)

select * from renamed_casted