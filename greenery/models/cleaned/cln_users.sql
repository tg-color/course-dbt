{{
  config(
    materialized='table'
  )
}}

SELECT 
    user_id as user_guid
   , first_name as user_first_name
   , last_name as user_last_name
   , email as user_email
   , phone_number as user_phone_number
   , created_at as user_created_at_utc
   , updated_at as user_updated_at_utc
   , address_id as address_guid
   
FROM {{ source('tutorial', 'users') }}