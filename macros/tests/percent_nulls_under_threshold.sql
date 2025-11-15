{% test percent_nulls_under_threshold(model, column_name, max_pct) %}
with base as (
  select
    count(*) as total,
    sum(case when {{ column_name }} is null then 1 else 0 end) as nulls
  from {{ model }}
)
select *
from base
where (nulls * 1.0) / nullif(total, 0) > cast({{ max_pct }} as float)
{% endtest %}
