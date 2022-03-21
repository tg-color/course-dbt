{{
  config(
    materialized='table'
  )
}}

SELECT 
order_id as order_guid
, product_id as product_guid
, quantity as product_quantity
 
FROM {{ source('tutorial', 'order_items') }}