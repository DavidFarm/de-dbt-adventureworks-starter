-- models/staging/sales__res_sales.sql
with src as (
  select * from {{ source('adventureworks', 'FactResellerSales') }}
)
select
  SalesOrderNumber        as sales_order_number,
  OrderDate               as order_date,
  SalesAmount             as sales_amount,
  OrderQuantity           as order_quantity,
  ProductKey              as product_key
from src;
