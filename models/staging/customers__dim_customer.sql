-- models/staging/customers__dim_customer.sql
with src as (
    select * from {{ source('adventureworks', 'DimCustomer') }}
)
select
    CustomerKey   as customer_key,
    FirstName     as first_name,
    LastName      as last_name,
    EmailAddress  as email_address
from src;
