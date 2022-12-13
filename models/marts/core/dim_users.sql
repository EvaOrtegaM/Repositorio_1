with stg_users as (

    select * from {{ ref('stg_sql_server_dbo_users') }}

),

renamed as (

    select
        user_id,
        first_name,
        last_name,        
        email,
        phone_number,        
        address_id,
        user_created_at_utc,
        user_updated_at_utc,        
        _fivetran_deleted,
        date_load

    from stg_users

)

select * from renamed