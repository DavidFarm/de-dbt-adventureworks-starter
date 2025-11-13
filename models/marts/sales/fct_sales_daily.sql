-- models/marts/sales/fct_sales_daily.sql
with f as (select * from {{ ref('int_sales_fact') }})
select
  order_date,
  sum(order_amount) as total_sales_amount,
  count(distinct sales_order_id) as orders
from f
group by order_date;
