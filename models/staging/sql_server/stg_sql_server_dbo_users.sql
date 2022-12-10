with source as (

    select * from {{ source('sql_server_dbo', 'users') }}

),

renamed as (

    select
        user_id,
        first_name,
        last_name,        
        email,
        phone_number,        
        address_id,
        created_at as user_created_at_utc,
        updated_at as user_updated_at_utc,        
        _fivetran_deleted as deletion_date,
        _fivetran_synced as date_load

    from source

)

select * from renamed