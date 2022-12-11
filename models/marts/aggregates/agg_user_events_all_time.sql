{% set event_types = obtener_valores(ref('stg_sql_server_dbo_events'),'event_type') %}

WITH stg_events AS (

    SELECT *
    FROM {{ ref('stg_sql_server_dbo_events') }}
    ),    

user_events as (

    select
        user_id,
        {%- for event_type in event_types   %}
        sum(case when event_type = '{{event_type}}' then 1 else 0 end) as {{event_type}}_amount
        {%- if not loop.last %},{% endif -%}
        {% endfor %}

    from stg_events 

    group by user_id

), 

sessions AS (

    SELECT 
        user_id
        ,count (distinct (product_id)) as products_searched
        ,count(order_id) as orders_amount
        ,min(event_created_at_utc) as first_session_date
        ,max(event_created_at_utc) as most_recent_session_date
        ,count(session_id) as number_of_sessions

    FROM {{ ref('stg_sql_server_dbo_events') }}
    group by user_id
    ),  

final as (
    select

        user_id

        {% for event_type in event_types -%}
        ,u.{{event_type}}_amount
        {% endfor -%}

        ,s.first_session_date
        ,s.most_recent_session_date
        ,s.number_of_sessions
        ,s.products_searched
        ,s.orders_amount

    from user_events u

    left join sessions s using(user_id)

    group by user_id,u.page_view_amount, u.add_to_cart_amount, u.package_shipped_amount, u.checkout_amount, 
    s.first_session_date, s.most_recent_session_date ,s.orders_amount, s.number_of_sessions ,s.products_searched
)

SELECT * FROM final