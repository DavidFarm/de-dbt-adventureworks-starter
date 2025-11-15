-- models/staging/sales__order_header.sql
with src as (
  select * from {{ source('adventureworks', 'FactInternetSales') }}
)
select
  SalesOrderNumber        as sales_order_number,
  CustomerKey             as customer_key,
  OrderDate               as order_date,
  SalesAmount             as sales_amount
from src;
