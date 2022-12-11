{{ config(
    materialized='incremental',
    unique_key = '_row'
    ) 
    }}


WITH stg_budget_products AS (
    SELECT * 
    FROM {{ ref('stg_google_sheets_budget') }}
    ),

renamed_casted AS (
    SELECT
          _row
        , to_char(budget_date, 'yyyymmdd') as id_date
        , month(budget_date) as month
        , monthname(budget_date) as desc_month
        , quantity 
        ,_fivetran_synced

    FROM stg_budget_products
    )

SELECT * FROM renamed_casted

{% if is_incremental() %}

  where _fivetran_synced > (select max(_fivetran_synced) from {{ this }})

{% endif %}