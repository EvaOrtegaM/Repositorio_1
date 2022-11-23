with source as (

    select * from {{ ref('stg_sql_server_dbo_users') }}

),

renamed as (

    select
        email,
        updated_at,
        address_id,
        created_at,
        phone_number,
        total_orders,
        user_id,
        first_name,
        last_name,
        _fivetran_deleted,
        _fivetran_synced

    from stg_users

)

select * from renamed 