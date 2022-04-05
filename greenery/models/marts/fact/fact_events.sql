{{
  config(
    materialized='table'
  )
}}


select
     de.event_guid
      , de.session_guid
      , de.user_guid
      , de.product_guid
      , de.event_page_url
      , de.event_created_at_date_utc
      , de.event_year
      , de.event_month
      , de.event_day
      , de.event_type
      , de.is_add_to_cart
      , de.is_checkout_no_order
      , de.is_checkout
      , de.is_page_view
      , de.is_shipped as is_shipped_event
      , de.product_name
      , de.product_price_usd
      , de.product_inventory
      , du.address_guid
      , du.user_first_name
      , du.user_last_name
      , du.user_full_name
      , du.user_email
      , du.user_phone_number
      , du.user_created_at_utc
      , du.user_created_year
      , du.user_created_month
      , du.user_created_day
      , du.user_updated_at_utc
      , du.user_updated_year
      , du.user_updated_month
      , du.user_updated_day
      , du.user_address
      , du.user_zipcode
      , du.user_state
      , du.user_country
      -- NEED TO BRING IN DIM ORDERS also this exercise is probably somewhere I could use the select * EXCEPT macro

      , orders.order_guid
      , orders.promo_name
      , orders.order_created_at_date_utc
      , orders.order_year
      , orders.order_month
      , orders.order_day
      , orders.order_estimated_delivery_date_utc
      , orders.order_delivered_at_date_utc
      , orders.is_shipped as is_shipped_order
      , orders.is_delivered
      , orders.days_to_deliver
      , orders.hours_to_deliver
      , orders.promo_discount_pct
      , orders.promo_status_current
      , orders.delivery_address
      , orders.delivery_zipcode
      , orders.delivery_state
      , orders.delivery_country
      , orders.order_cost_usd
      , orders.order_shipping_cost_usd
      , orders.order_total_cost_usd
      , orders.is_first_order
      , orders.is_latest_order
      , orders.products_in_purchase_distinct
      , orders.products_in_purchase_total
      , orders.order_quantity_total

from {{ ref('dim_events') }} as de

left join {{ ref('dim_users') }} as du on de.user_guid = du.user_guid
left join {{ ref('dim_orders') }} as orders on de.user_guid = orders.user_guid