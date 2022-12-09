WITH stg_budget AS (
    SELECT * 
    FROM {{ ref('stg_google_sheets_budget') }}
),

renamed_casted AS (
    SELECT

        _row
        , month
        , quantity 
        ,_fivetran_synced 

    FROM stg_budget
    )

SELECT * FROM renamed_casted