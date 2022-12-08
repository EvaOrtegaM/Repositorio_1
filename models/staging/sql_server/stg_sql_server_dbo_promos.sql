with source as (

    select * from {{ source('sql_server_dbo', 'promos') }}

),

renamed as (

    select

        md5(promo_id) as promo_id,
        promo_id as promo_description,        
        status as status_promo,
        discount,
        _fivetran_deleted,
        _fivetran_synced as date_load 

    from source

)

select * from renamed

union all 
select md5('') as promo_id, 'No promotion', 'inactive', 0, 'false', sysdate()