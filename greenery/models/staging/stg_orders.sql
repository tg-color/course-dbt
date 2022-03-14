{{
  config(
    materialized='table'
  )
}}

SELECT 
order_id as order_guid
, promo_id as promo_guid
, user_id as user_guid
, address_id address_guid
, created_at as order_created_at_date
, order_cost
, shipping_cost as order_shipping_cost
, order_total
, tracking_id as order_tracking_id
, shipping_service as order_shipping_service
, estimated_delivery_at as order_estimated_delivery_date
, delivered_at as order_delivered_at_date
, status as order_status
 
FROM {{ source('tutorial', 'orders') }}