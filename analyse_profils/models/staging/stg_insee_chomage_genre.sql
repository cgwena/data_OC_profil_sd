select 
    Annee,
    round(avg(REPLACE(Femmes, ',', '.')::NUMBER(10,2)), 1) as chomage_femmes,
    round(avg(REPLACE(Hommes, ',', '.')::NUMBER(10,2)), 1) as chomage_hommes,
    round(avg(REPLACE(Ensemble, ',', '.')::NUMBER(10,2)), 1) as chomage_ensemble
from {{ source('data_analysis', 'insee_chomage_genre')}}
where Annee between 2022 and 2025
group by Annee