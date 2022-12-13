
{% set event_types = obtener_valores(ref('fct_events'),'event_type') %}

WITH events AS (

    SELECT *
    FROM {{ ref('fct_events') }}
    ),    

users AS (

    SELECT *
    FROM {{ ref('dim_users') }}
    ),    


user_events as (

    select
        user_id,
        {%- for event_type in event_types   %}
        sum(case when event_type = '{{event_type}}' then 1 else 0 end) as {{event_type}}_amount
        {%- if not loop.last %},{% endif -%}
        {% endfor %}

    from events 

    group by user_id

), 

sessions AS (

    SELECT 
        user_id
        ,u.first_name
        ,u.last_name
        ,count (distinct (e.product_id)) as products_searched
        ,count(distinct (e.order_id)) as number_of_orders
        ,min(e.event_created_at_utc) as first_session_date
        ,max(e.event_created_at_utc) as most_recent_session_date
        ,count(e.session_id) as number_of_sessions

    FROM events e
    left join users u using(user_id)
    
    group by user_id, u.first_name ,u.last_name
    ),  

final as (
    select

        user_id
        ,s.first_name
        ,s.last_name        

        {% for event_type in event_types -%}
        ,u.{{event_type}}_amount
        {% endfor -%}

        ,s.first_session_date
        ,s.most_recent_session_date
        ,s.number_of_sessions
        ,s.products_searched
        ,s.number_of_orders

    from user_events u

    left join sessions s using(user_id)

    group by user_id,s.first_name,s.last_name ,u.page_view_amount, u.add_to_cart_amount, u.package_shipped_amount, u.checkout_amount, 
    s.first_session_date, s.most_recent_session_date ,s.number_of_orders, s.number_of_sessions ,s.products_searched
)

SELECT * FROM final