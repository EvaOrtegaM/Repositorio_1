
WITH stg_budget_products AS (
    SELECT * 
    FROM {{ ref('stg_google_sheets_budget') }}
    ),

renamed_casted AS (
    SELECT
          _row
        , budget_date
        , to_char(budget_date, 'yyyymmdd') as id_date
        , monthname(budget_date) as desc_month
        , quantity 
        , product_id
        ,_fivetran_synced

    FROM stg_budget_products
    )

SELECT * FROM renamed_casted
