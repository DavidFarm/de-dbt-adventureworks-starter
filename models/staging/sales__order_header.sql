-- models/staging/sales__order_header.sql
with src as (
  select * from {{ source('adventureworks','SalesOrderHeader') }}
)
select
  cast(SalesOrderID as int)          as sales_order_id,
  cast(CustomerID as int)            as customer_id,
  cast(OrderDate as date)            as order_date,
  cast(ModifiedDate as datetime2)    as modified_ts,
  cast(SubTotal as decimal(18,2))    as subtotal_amount
from src;
