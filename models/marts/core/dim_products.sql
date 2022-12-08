
WITH stg_products AS (

    SELECT * 
    FROM {{ ref('stg_sql_server_dbo_products') }}

    ),

products AS (
    SELECT

    product_id
    ,product_description
    ,price_usd
    ,inventory
    ,date_load

    FROM stg_products
    )

SELECT * FROM products