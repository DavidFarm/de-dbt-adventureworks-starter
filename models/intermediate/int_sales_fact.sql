-- models/intermediate/int_sales_fact.sql
{{ config(materialized='incremental', unique_key='sales_order_number') }}

with orders as (
  select * from {{ ref('sales__order_header') }}
)

select
  sales_order_number,
  customer_key,
  order_date,
  sales_amount as order_amount
from orders
{% if is_incremental() %}
where order_date > (select coalesce(max(order_date), '1900-01-01') from {{ this }})
{% endif %};
