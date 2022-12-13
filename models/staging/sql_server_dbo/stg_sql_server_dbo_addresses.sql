with source as (

    select * from {{ source('sql_server_dbo', 'addresses') }}

),

renamed as (

    select

        address_id,
        address,
        state,
        country,
        zipcode,
        _fivetran_deleted,
        _fivetran_synced as date_load

    from source

)

select * from renamed