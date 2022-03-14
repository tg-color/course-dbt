
WEEK 1 PROJECT

**QUESTION ONE**

HOW MANY USERS DO WE HAVE?
**Answer: 130**

```sql
select 

count (distinct user_guid ) as user_count

from dbt.dbt_travis_g.stg_users
```
**QUESTION TWO**

ON AVERAGE, HOW MANY ORDERS DO WE RECEIVE PER HOUR?
**Answer: 7.53 order** 
```sql
select

min(order_created_at_date) as min_order_date
, max(order_created_at_date) as max_order_date
, round(EXTRACT (EPOCH FROM (max(order_created_at_date) - min(order_created_at_date))/3600)) as date_difference 
, count (distinct order_guid) as total_orders
, count (distinct order_guid)/ EXTRACT (EPOCH FROM (max(order_created_at_date) - min(order_created_at_date))/3600) as average_orders_hour

from dbt.dbt_travis_g.stg_orders
```
**QUESTION THREE**

ON AVERAGE, HOW LONG DOES AN ORDER TAKE FROM BEING PLACED TO BEING DELIVERED?
**Asnwer 3.89 days or 93 hours**
```sql
with order_time as
(
select 

order_guid
, order_created_at_date
, order_delivered_at_date
, round(extract (EPOCH from (order_delivered_at_date - order_created_at_date))/86400) as days_to_deliver
, round(extract (EPOCH from (order_delivered_at_date - order_created_at_date))/3600) as hours_to_deliver
from dbt.dbt_travis_g.stg_orders 

where order_delivered_at_date is not null
)

select 

avg (days_to_deliver) as avg_days_to_deliver
, avg (hours_to_deliver) as avg_hours_to_deliver

from order_time
```
**QUESTION FOUR**

HOW MANY USERS HAVE ONLY MADE ONE PURCHASE? TWO PURCHASES? THREE+ PURCHASES?
**Answer:**

| orders_group | user_count |
| ----------- | ----------- |
| 1 purchase  | 25 |
| 2 purchases | 28 |
| 3+ purchases | 71 |
```sql
with purchases as
(
select 

user_guid
, case 
       when count(distinct order_guid) = 1 then '1 purchase'
       when count(distinct order_guid) = 2 then '2 purchases'
       when count(distinct order_guid) >= 3 then '3+ purchases'
       else 'error'
 end purchase_count

from dbt.dbt_travis_g.stg_orders  

group by 1
)

select

purchase_count
, count(distinct user_guid)

from purchases

group by 1
```
**QUESTION FIVE**

ON AVERAGE, HOW MANY UNIQUE SESSIONS DO WE HAVE PER HOUR?
**Answer: 16.33**

```sql
with sessions_per_hour as 
(
select

date_trunc('hour', event_created_at_date) as hour_created_at
, count(distinct session_guid) as count_sessions

from dbt.dbt_travis_g.stg_events

group by 1
)

select
round(avg(count_sessions), 2)
from sessions_per_hour
```
