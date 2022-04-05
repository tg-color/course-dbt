{{
  config(
    materialized='table'
  )
}}


select

     fso.product_guid
      , fso.product_name
      , count (distinct fso.session_guid) as purchase_sessions_count

from {{ ref('fact_session_order') }} as fso

group by 1,2


/*

     de.event_guid
      , de.session_guid
      , de.user_guid
      , de.order_guid
      , de.event_page_url
      , de.event_created_at_date_utc
      , de.event_year
      , de.event_month
      , de.event_day
      , de.is_checkout
      , de.product_price_usd
      , de.product_inventory
      , cp.product_guid
      , cp.product_name
      , coi.product_quantity














*/