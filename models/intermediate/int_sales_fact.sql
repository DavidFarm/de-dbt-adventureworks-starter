-- models/intermediate/int_sales_fact.sql
{{ config(materialized='incremental', unique_key='sales_order_number') }}

with orders as (
    select * from {{ ref('sales__order_header') }}
    {% if is_incremental() %}
    where order_date > (
        select coalesce(max(order_date), '1900-01-01')
        from {{ this }}
    )
    {% endif %}
)

select
    sales_order_number,
    customer_key,
    min(order_date)              as order_date,
    sum(sales_amount)            as order_amount,
    count(*)                     as line_count
from orders
group by
    sales_order_number,
    customer_key;
