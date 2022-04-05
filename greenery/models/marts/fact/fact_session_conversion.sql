{{
  config(
    materialized='table'
  )
}}

with items_in_purchase as
(
select

    fe.session_guid
      -- NEED TO BRING IN DIM ORDERS also this exercise is probably somewhere I could use the select * EXCEPT macro
     , sum( fe.is_checkout) as items_in_purchase
  -- , count(distinct fe.order_guid) as is_purchase;

from {{ ref('fact_events') }} as fe
group by 1 
)

select 
iip.session_guid
    , case
           when (iip.items_in_purchase) >= 1 then 1.0
           else 0
      end is_session_purchase

from items_in_purchase iip




/*

     fe.event_guid
      , fe.session_guid
      , fe.user_guid
      , fe.event_page_url
      , fe.event_created_at_date_utc
      , fe.event_year
      , fe.event_month
      , fe.event_day
      , fe.event_type
      , fe.is_add_to_cart
      , fe.is_checkout_no_order
      , fe.is_checkout
      , fe.is_page_view
      , fe.is_shipped_event
      , fe.product_name
      , fe.product_price_usd
      , fe.product_inventory
      , fe.address_guid
      , fe.user_first_name
      , fe.user_last_name
      , fe.user_full_name
      , fe.user_email
      , fe.user_phone_number
      , fe.user_created_at_utc
      , fe.user_created_year
      , fe.user_created_month
      , fe.user_created_day
      , fe.user_updated_at_utc
      , fe.user_updated_year
      , fe.user_updated_month
      , fe.user_updated_day
      , fe.user_address
      , fe.user_zipcode
      , fe.user_state
      , fe.user_country
      -- NEED TO BRING IN DIM ORDERS also this exercise is probably somewhere I could use the select * EXCEPT macro
      , fe.order_guid
      , fe.promo_name
      , fe.order_created_at_date_utc
      , fe.order_year
      , fe.order_month
      , fe.order_day
      , fe.order_estimated_delivery_date_utc
      , fe.order_delivered_at_date_utc
      , fe.is_shipped_order
      , fe.is_delivered
      , fe.days_to_deliver
      , fe.hours_to_deliver
      , fe.promo_discount_pct
      , fe.promo_status_current
      , fe.delivery_address
      , fe.delivery_zipcode
      , fe.delivery_state
      , fe.delivery_country
      , fe.order_cost_usd
      , fe.order_shipping_cost_usd
      , fe.order_total_cost_usd
      , fe.is_first_order
      , fe.is_latest_order
      , fe.products_in_purchase_distinct
      , fe.products_in_purchase_total
      , fe.order_quantity_total
      */