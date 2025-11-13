-- snapshots/person_snapshot.sql
{% snapshot person_snapshot %}
{{
  config(
    target_database='AdventureWorks',
    target_schema='dbt_snapshots',
    unique_key='BusinessEntityID',
    strategy='timestamp',
    updated_at='ModifiedDate'
  )
}}
select BusinessEntityID, FirstName, LastName, ModifiedDate
from {{ source('adventureworks','Person') }}
{% endsnapshot %}
