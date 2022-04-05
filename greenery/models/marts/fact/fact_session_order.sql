{{
  config(
    materialized='table'
  )
}}


select
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


from {{ ref('dim_events') }} as de

left join {{ ref('dim_orders') }} as orders on de.user_guid = orders.user_guid
left join {{ ref('cln_order_items')}} as coi on de.order_guid = coi.order_guid
left join {{ ref('cln_products') }} as cp on coi.product_guid = cp.product_guid

where de.is_checkout = 1