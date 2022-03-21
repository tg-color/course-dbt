## WEEK 2 PROJECT

**QUESTION ONE** - What is our user repeat rate?

**Answer: 79.8%**

```sql
select 

     sum(is_purchased_user) as purchased_users_total
     , sum(is_repeat_purchase_user) as repeat_purchased_users_total
     , sum(is_repeat_purchase_user)/sum(is_purchased_user) as repeat_user_rate
from dbt.dbt_travis_g.fact_user_oder_agg

```
**QUESTION TWO** - What are good indicators of a user who will likely purchase again? What about indicators of users who are likely NOT to purchase again?
If you had more data, what features would you want to look into to answer this question? 
      NOTE: Hypothetical question vs. something we can analyze in our Greenery data set. 
            Think about what exploratory analysis you would do to approach this question.



**Answer: For people who will likely purchase again I would want to dive into session information after a repeat purchaser's first purchase and before
their second purchase and then again after second and before third, and so on. Focusing on product page views, number of sessions, time between sessions,
times a page was viewed and other interactions with a product page, add-to-cart, etc. Similarly for not likely to purchase again, I would look to analyze 
single purchasers to see if there were trends there, e.g. fewer sessions and other activivty post first-purchase and look for differences between behaviors 
prior to first purchase across the two cohorts. 


**marts folder** 

I didn't find Core/Marketing/Product to be a good fit for me, so I just created folders for dim, fact and int to keep things organized for now.
I can see how for very large projects or very audience-specific models it may make sense to create a more 'department' based file structure.

**tests**

I did not have time to build a lot of tests, but would like to experiment more with custom tests. I mostly used is unique and is not null tests on appropriate
keyed fields. I didn't have any issues with the tests but I can see the need to add more robust testing.


**Stakeholders understanding the state of data each day. Explain how you would ensure these tests are passing regularly and how you would alert stakeholders
about bad data getting through.**

I would set up a regular test cadence (daily, or each time the jobs ran if more frequently than daily) so we could track results. Depending on how bad 
a test failure was I would either use a slack channel message or slack channel + direct messages to communicate the issue. If it was escalated I would
follow any process set up by my company to handle it.
