with stg_age as (
    select * from {{ ref('stg_insee_chomage_age') }}
),

unpivoted_age as (
    select
        annee,
        age,
        taux_chomage_age
    from stg_age
    UNPIVOT (
        taux_chomage_age for age in ("15-24 ans", "25-49 ans", "50 ans ou plus") 
    )
)

select 
    annee,
    age, 
    ROUND(AVG(taux_chomage_age), 2) as taux_chomage_age
from unpivoted_age
group by 
    annee, 
    age