{{
  config(
    materialized='table'
  )
}}

select 
     ce.event_guid
      , ce.session_guid
      , ce.user_guid
      , ce.event_page_url
      , ce.event_created_at_date_utc
      , to_char(ce.event_created_at_date_utc, 'yyyy') as event_year
      , to_char(ce.event_created_at_date_utc, 'Month') as event_month
      , to_char(ce.event_created_at_date_utc, 'Day') as event_day
      , ce.event_type
      , case
           when (ce.event_type) = 'add_to_cart' then 1
           else 0
        end is_add_to_cart
      , case
           when (ce.event_type) = 'checkout' and (ce.order_guid) is null then 1
           else 0
        end is_checkout_no_order
      , case
           when (ce.event_type) = 'checkout' then 1
           else 0
        end is_checkout    
      , case
           when (ce.event_type) = 'page_view' then 1
           else 0
        end is_page_view    
      , case
           when (ce.event_type) = 'package_shipped' then 1
           else 0
        end is_shipped
      , ce.order_guid
      , ce.product_guid
      , cp.product_name
      , cp.product_price_usd
      , cp.product_inventory

FROM {{ ref('cln_events') }} ce

left join {{ ref('cln_products') }} cp on ce.product_guid = cp.product_guid