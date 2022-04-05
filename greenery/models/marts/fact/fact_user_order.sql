/* should be one line item per user per order */

{{
  config(
    materialized='table'
  )
}}

select

    du.user_guid
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
-- would like to add customer tenure in (years, months, days) but was having trouble/moved on. 
    , du.user_address
    , du.user_zipcode
    , du.user_state
    , du.user_country
-- add dim_order_fields 
    , dor.order_guid 
    , dor.promo_name
    , dor.promo_discount_pct
    , dor.promo_status_current
    , dor.order_created_at_date_utc
    , dor.order_delivered_at_date_utc
    , dor.is_shipped
    , dor.is_delivered
    , dor.order_year
    , dor.order_month
    , dor.order_day
    , dor.delivery_address
    , dor.delivery_zipcode
    , dor.delivery_state
    , dor.delivery_country
    , dor.order_cost_usd
    , dor.order_shipping_cost_usd
    , dor.order_total_cost_usd
    , dor.products_in_purchase_distinct
    , dor.products_in_purchase_total 
    , dor.order_quantity_total 


from {{ ref('dim_users') }} du

inner join {{ ref('dim_orders')}} dor on du.user_guid = dor.user_guid

--group by (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40)


