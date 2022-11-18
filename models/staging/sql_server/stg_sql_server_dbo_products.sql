
WITH src_sql_server_dbo AS (
    SELECT * 
    FROM {{ source('sql_server_dbo', 'products') }}
    ),

productos AS (
    SELECT
    product_id
    ,price as price_$
    ,name
    ,inventory
    ,_fivetran_deleted
    ,_fivetran_synced
    FROM src_sql_server_dbo
    )

SELECT * FROM productos


