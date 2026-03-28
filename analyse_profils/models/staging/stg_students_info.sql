select 
    concat(user_id, year_path_started) as student_year_id,
    user_id,
    path_category_name,
    age_group as oc_age_group,
    case 
        when age_group in ('20-24 ans') then '15-24 ans'
        when age_group in ('25-29 ans','30-34 ans','35-39 ans','40-44 ans','45-49 ans') then '25-49 ans'
        when age_group in ('50-54 ans', '55-59 ans', '60 ans ou plus') then '50 ans ou plus'
        else 'unknown'
    end as insee_age_group,
    coalesce(gender, 'unknown') as gender,
    region,
    year_path_started
from {{ source('data_analysis','students_info') }}