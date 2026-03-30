select
    Annee,
    round(avg(taux_femmes), 1) as chomage_femmes,
    round(avg(taux_hommes), 1) as chomage_hommes,
    round(avg(taux_ensemble_genre), 1) as chomage_ensemble_genre
from {{ ref('stg_insee_chomage_genre')}}
group by Annee