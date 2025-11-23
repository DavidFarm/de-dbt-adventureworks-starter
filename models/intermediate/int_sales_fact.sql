-- models/intermediate/int_sales_fact.sql
{#
    Model: int_sales_fact
    Grain: 1 row per order
    Purpose: 
      - Aggregate line-level data from FactInternetSales 
        into order-level facts.
      - Used by daily fct_sales_daily mart.
    Incremental logic:
      - Only load rows with order_date > max(order_date) in existing table.
      - Safe because AdventureWorksDW2022 has static and well-ordered dates.
#}

{{ config(
    materialized='incremental',
    unique_key='sales_order_number',
    on_schema_change='sync_all_columns'
) }}

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
    count(*)                     as line_count,
    max(order_date)              as updated_at
from orders
group by
    sales_order_number,
    customer_key;
