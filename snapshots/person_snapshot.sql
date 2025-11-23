-- snapshots/person_snapshot.sql
{% snapshot customer_snapshot %}
{{
  config(
    target_database='AdventureWorksDW2022',
    target_schema='dbt_snapshots',
    unique_key='customer_key',
    strategy='check',
    check_cols=['first_name', 'last_name', 'email_address']
  )
}}

select
    cast(CustomerKey as int)  as customer_key, -- Trying to get rid of IDENTITY
    FirstName    as first_name,
    LastName     as last_name,
    EmailAddress as email_address
from {{ source('adventureworks', 'DimCustomer') }}

{% endsnapshot %}
