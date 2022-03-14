{{
  config(
    materialized='table'
  )
}}

SELECT 
    event_id as event_guid
    , session_id as session_guid
    , user_id as user_guid
    , page_url as event_page_url
    , created_at as event_created_at_date
    , event_type 
    , order_id as order_guid
    , product_id as product_guid
 
FROM {{ source('tutorial', 'events') }}