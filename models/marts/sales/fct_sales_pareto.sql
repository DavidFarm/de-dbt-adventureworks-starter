-- models/marts/sales/fct_sales_pareto.sql
with tot_sales as (
    select * from {{ ref("tot_sales_fact") }} 
),
products as (
    select * from {{ ref("products_dim_product") }} 
),
category as (
    select * from {{ ref("products_dim_subcategory") }} 
),
total_all as (
	select SUM(order_quantity * sales_amount) as total from tot_sales
),
total_prod as (
	select 
        product_key, 
        SUM(order_quantity * sales_amount) as sales
	from tot_sales
	group by product_key
),
final as (
	select 
		s.product_key,
		s.sales as total_sales,
		s.sales / total_all.total * 100 as perc_total,
		SUM(s.sales) over (order by s.sales desc rows between unbounded preceding and current row) as running_total,
        rank() over(order by s.sales desc) as ranking
	from
		total_prod as s, total_all
	)
select 
	p.product_name,
	c.subcategory_name as category,
	s.total_sales,
	s.perc_total,
	s.running_total,
    s.running_total / total_all.total as running_perc,
    s.ranking
from final as s join products p on s.product_key = p.product_key 
	join category as c on c.subcategory_key = p.subcategory_key, total_all
where running_total <= total_all.total * 0.8
