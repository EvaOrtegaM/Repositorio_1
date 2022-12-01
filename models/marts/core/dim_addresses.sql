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
        date_load

    from stg_addresses

)

select * from renamed_casted