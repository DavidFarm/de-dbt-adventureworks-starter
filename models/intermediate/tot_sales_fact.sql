-- models/intermediate/tot_sales_fact.sql
{#
    Model: tot_sales_fact
    Grain: 1 row per order
    Purpose: 
      - Combine sales data from FactInternetSales and FactResellerSales into one table.
      - Used by fct_sales_pareto.
#}

select
  sales_order_number,
  order_date,
  sales_amount,
  order_quantity,
  product_key
from {{ ref('sales__order_header') }}
union all
select 
  sales_order_number,
  order_date,
  sales_amount,
  order_quantity,
  product_key
from {{ ref('sales__res_sales') }}
