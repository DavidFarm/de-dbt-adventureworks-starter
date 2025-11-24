-- models/staging/products_di_product.sql
with src as (
    select * from {{ source('adventureworks', 'DimProduct') }}
)
select
    ProductKey                      as product_key,
    ProductSubCategoryKey  as subcategory_key,
    EnglishProductName              as product_name
from src;
