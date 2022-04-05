{{
  config(
    materialized='table'
  )
}}

select 
    co.order_guid
    , co.promo_name
    , co.user_guid
    , co.address_guid
    , co.order_created_at_date_utc
    , to_char(co.order_created_at_date_utc, 'yyyy') as order_year
    , to_char(co.order_created_at_date_utc, 'Month') as order_month
    , to_char(co.order_created_at_date_utc, 'Day') as order_day
    , co.order_estimated_delivery_date_utc
    , co.order_delivered_at_date_utc
    , case
           when (co.order_tracking_id) is not null then 1
           else 0
      end is_shipped    
    , case
           when (order_delivered_at_date_utc) is not null then 1
           else 0
      end is_delivered
-- when I figure out the date math from current time stamp add a days since ordered for not unshipped orders
    , round(extract (EPOCH from (co.order_delivered_at_date_utc - co.order_created_at_date_utc))/86400) as days_to_deliver
    , round(extract (EPOCH from (co.order_delivered_at_date_utc - co.order_created_at_date_utc))/3600) as hours_to_deliver
    , cp.promo_discount as promo_discount_pct
    , cp.promo_status as promo_status_current
    , ca.address as delivery_address
    , ca.zipcode as delivery_zipcode
    , ca.state as delivery_state
    , ca.country as delivery_country
    , co.order_cost_usd
    , co.order_shipping_cost_usd
    , co.order_total_cost_usd
    , coi.product_guid
    , cpdt.product_name    
    , min (co.order_created_at_date_utc) as is_first_order
    , max (co.order_created_at_date_utc) as is_latest_order
-- I had some issues with creating an int table for order items to aggregate things in other ways before bringing in these below
    , count (distinct coi.product_guid) as products_in_purchase_distinct
    , count (coi.product_guid) as products_in_purchase_total --should equal quantity below
    , sum (coi.product_quantity) as order_quantity_total

FROM {{ ref('cln_orders') }} co

left join {{ ref('cln_addresses') }} ca on co.address_guid = ca.address_guid
left join {{ ref('cln_promos') }} cp on co.promo_name = cp.promo_name
left join {{ ref('cln_users') }} cu on co.user_guid = cu.user_guid
left join {{ ref('cln_order_items') }} coi on co.order_guid = coi.order_guid
left join {{ ref('cln_products') }} cpdt on coi.product_guid = cpdt.product_guid


{{ dbt_utils.group_by(n=25) }}

--group by (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23)


/*
figure out how to add an is_first_order flag OR maybe just do a rank of each users order and pull
in the specific order number, e.g. 1, 2, 3, etc
   
   
    , case
           when min (dor.is_first_order) is not null then 1
           else 0
      end is_first_order    
    , case
           when (dor.is_latest_order) is not null then 1
           else 0
      end is_latest_order
      */