
WITH src_sql_server_dbo AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'products') }}
    ),

productos AS (
    SELECT
    product_id
    ,name
    ,price as price_usd
    ,inventory
    ,_fivetran_deleted
    ,_fivetran_synced as date_load

    FROM src_sql_server_dbo
    )

SELECT * FROM productos


