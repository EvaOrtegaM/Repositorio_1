with stg_users as (

    select * from {{ ref('stg_sql_server_dbo_orders') }}

),

renamed_casted as (

    select
        email,
        updated_at_utc,
        address_id,
        created_at_utc,
        phone_number,
        user_id,
        first_name,
        last_name,
        _fivetran_deleted,
        _fivetran_synced

    from stg_users

)

select * from renamed_casted