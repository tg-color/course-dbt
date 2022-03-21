{{
  config(
    materialized='table'
  )
}}

SELECT 
order_id as order_guid
, promo_id as promo_name
, user_id as user_guid
, address_id address_guid
, created_at as order_created_at_date_utc
, order_cost as order_cost_usd
, shipping_cost as order_shipping_cost_usd
, order_total as order_total_cost_usd
, tracking_id as order_tracking_id
, shipping_service as order_shipping_service
, estimated_delivery_at as order_estimated_delivery_date_utc
, delivered_at as order_delivered_at_date_utc
, status as order_status
 
FROM {{ source('tutorial', 'orders') }}