with stg_order_items as (

    select * from {{ ref('stg_sql_server_dbo_order_items') }}
  
),

renamed as (

    select
        order_id,
        product_id,
        quantity,
        deletion_date,
        date_load

    from stg_order_items

)

select * from renamed