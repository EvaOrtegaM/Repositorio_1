with source as (

    select * from {{ source('sql_server_dbo', 'users') }}

),

renamed as (

    select
        email,
        updated_at,
        address_id,
        created_at,
        phone_number,
        user_id,
        first_name,
        last_name,
        _fivetran_deleted,
        _fivetran_synced

    from source

)

select * from renamed