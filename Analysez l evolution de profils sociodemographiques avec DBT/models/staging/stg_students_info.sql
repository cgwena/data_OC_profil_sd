{{ config(materialized='view')}}

select 
    user_id,
    path_category_name,
    age_group,
    coalesce(gender, 'unknown') as gender,
    region,
    year_path_started
from {{ source('data_analysis','students_info') }}