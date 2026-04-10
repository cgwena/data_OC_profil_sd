with data_preparee as (
    select 
        Annee,
        taux_15_24,
        taux_25_49,
        taux_50_plus,
        Ensemble
    from {{ ref('stg_insee_chomage_age'))}}
),

unpivoted_age as (
    select
        Annee,
        age,
        taux_chomage_age
    from data_preparee
    unpivot (
        taux_chomage_age for age in (taux_15_24, taux_25_49, taux_50_plus, Ensemble) 
    )
)

select 
    Annee,
    age,
    round(avg(taux_chomage_age), 2) as taux_chomage_age
from unpivoted_ge
group by Annee, age