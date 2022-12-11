
WITH src_sql_server_dbo AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'products') }}
    ),

renamed AS (
    SELECT
    product_id
    ,name as product_description
    ,price as price_usd
    ,inventory
    ,_fivetran_deleted as deletion_date
    ,_fivetran_synced as date_load

    FROM src_sql_server_dbo
    )

SELECT * FROM renamed


