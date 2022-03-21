{{
  config(
    materialized='table'
  )
}}

select 
    cu.user_guid
    , cu.address_guid
    , cu.user_first_name
    , cu.user_last_name
    , concat (cu.user_first_name,' ',cu.user_last_name) as user_full_name
    , cu.user_email
    , cu.user_phone_number
    , cu.user_created_at_utc
    , to_char(cu.user_created_at_utc, 'yyyy') as user_created_year
    , to_char(cu.user_created_at_utc, 'Month') as user_created_month
    , to_char(cu.user_created_at_utc, 'dd') as user_created_day
    , cu.user_updated_at_utc
    , to_char(cu.user_updated_at_utc, 'yyyy') as user_updated_year
    , to_char(cu.user_updated_at_utc, 'Month') as user_updated_month
    , to_char(cu.user_updated_at_utc, 'dd') as user_updated_day
--  , would like to add customer tenure in (years, months, days) but was having trouble/moved on. 
    , ca.address as user_address
    , ca.zipcode as user_zipcode
    , ca.state as user_state
    , ca.country as user_country


FROM {{ ref('cln_users') }} cu

join {{ ref('cln_addresses') }} ca on cu.address_guid = ca.address_guid