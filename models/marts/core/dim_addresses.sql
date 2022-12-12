with stg_addresses as (

    select * from {{ ref('stg_sql_server_dbo_addresses') }}

),

renamed_casted as (

    select

        address_id,
        address,
        state,
        country,
        zipcode,
        date_load

    from stg_addresses

)

select * from renamed_casted