-- models/intermediate/int_sales_fact.sql
{{ config(materialized='incremental', unique_key='sales_order_id') }}

with o as (select * from {{ ref('sales__order_header') }}),
     d as (select * from {{ source('adventureworks','SalesOrderDetail') }})

select
  o.sales_order_id,
  o.customer_id,
  o.order_date,
  sum(cast(d.LineTotal as decimal(18,2))) as order_amount
from o
join d on d.SalesOrderID = o.sales_order_id
{% if is_incremental() %}
where o.order_date > (select coalesce(max(order_date),'1900-01-01') from {{ this }})
{% endif %}
group by 1,2,3;
