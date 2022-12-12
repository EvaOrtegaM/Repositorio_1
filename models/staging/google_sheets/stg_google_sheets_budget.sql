
WITH stg_budget_products AS (
    SELECT * 
    FROM {{ source('google_sheets','budget') }}
    ),

renamed_casted AS (
    SELECT
          _row
        , month as budget_date
        , quantity 
        , product_id
        ,_fivetran_synced 
        
    FROM stg_budget_products
    )

SELECT * FROM renamed_casted



