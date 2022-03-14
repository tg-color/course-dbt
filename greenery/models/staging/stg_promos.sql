{{
  config(
    materialized='table'
  )
}}

SELECT 
 promo_id as promo_guid
 , discount as promo_discount
 , status as promo_status
 
FROM {{ source('tutorial', 'promos') }}