-- models/staging/products_dim_subcategory.sql
with src as (
    select * from {{ source('adventureworks', 'DimProductSubcategory') }}
)
select
    ProductSubCategoryKey           as subcategory_key,
    EnglishProductSubcategoryName   as subcategory_name,
    ProductCategoryKey              as subcategory_category_key
from src;
