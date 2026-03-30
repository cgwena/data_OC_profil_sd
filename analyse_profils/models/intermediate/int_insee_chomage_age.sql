select 
    Annee,
    round(avg(taux_15_24), 1) as chomage_15_24,
    round(avg(taux_25_49), 1) as chomage_25_49,
    round(avg(taux_50_plus), 1) as chomage_50_plus,
    round(avg(taux_ensemble_age), 1) as chomage_ensemble_age
from {{ ref('stg_insee_chomage_age')}}
group by Annee