{{
  config(
    materialized='table'
  )
}}

SELECT 
 product_id as product_guid
 , name as product_name
 , price as product_price_usd
 , inventory as product_inventory
 
FROM {{ source('tutorial', 'products') }}