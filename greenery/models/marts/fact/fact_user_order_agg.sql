/* should be one line item per user */

{{
  config(
    materialized='table'
  )
}}

select 

     fuo.user_guid
     , fuo.address_guid
     , fuo.user_first_name
     , fuo.user_last_name
     , fuo.user_full_name
     , fuo.user_email
     , fuo.user_phone_number
     , fuo.user_address
     , fuo.user_zipcode
     , fuo.user_state
     , fuo.user_country
     , count (fuo.order_guid) as user_order_count
    , case
           when count (fuo.order_guid) = 1 then 1.0
           else 0
      end is_purchased_user
    , case
           when count (fuo.order_guid) > 1 then 1.0
           else 0
      end is_repeat_purchase_user
     , count (fuo.promo_name) as user_promo_total
     , avg (fuo.promo_discount_pct) as avg_discount_pct
     , sum (fuo.is_shipped) as total_orders_shipped
     , sum (fuo.is_delivered) as total_orders_delivered
     , sum (fuo.order_cost_usd) as lifetime_order_cost_usd
     , sum (fuo.order_shipping_cost_usd) as lifetime_shipping_cost_usd
     , sum (fuo.order_total_cost_usd) as lifetime_order_total_usd
     , sum (fuo.order_quantity_total) as lifetime_order_quantity_total
  

from {{ ref('fact_user_order') }} fuo

{{ dbt_utils.group_by(n=11) }}
--group by (1,2,3,4,5,6,7,8,9,10,11)