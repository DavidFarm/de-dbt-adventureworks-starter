-- snapshots/person_snapshot.sql
{% snapshot customer_snapshot %}
{{
  config(
    target_database='AdventureWorksDW2022',
    target_schema='dbt_snapshots',
    unique_key='CustomerKey',
    strategy='check',
    check_cols=['FirstName', 'LastName', 'EmailAddress']
  )
}}

select *
from {{ source('adventureworks', 'DimCustomer') }}

{% endsnapshot %}
