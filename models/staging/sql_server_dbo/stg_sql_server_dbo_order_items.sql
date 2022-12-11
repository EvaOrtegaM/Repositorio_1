with source as (

    select * from {{ source('sql_server_dbo', 'order_items') }}

),

renamed as (

    select
        order_id,
        product_id,
        quantity,
        _fivetran_deleted as deletion_date,
        _fivetran_synced as date_load

    from source

)

select * from renamed