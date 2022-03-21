/* WIP */

{{
  config(
    materialized='table'
  )
}}

select 
    coi.order_guid
    , coi.product_guid
    , coi.product_quantity
    , sum (coi.product_quantity) over (partition by coi.order_guid) as quantity_by_order
    

FROM {{ ref('cln_order_items') }} coi
group by 1,2,3