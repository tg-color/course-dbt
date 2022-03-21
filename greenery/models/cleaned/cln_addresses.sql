{{
  config(
    materialized='table'
  )
}}

SELECT 
  address_id as address_guid
  , address
  , zipcode
  , state
  , country

FROM {{ source('tutorial', 'addresses') }}