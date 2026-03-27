select 
    Annee,
    round(avg(REPLACE("15-24 ans", ',', '.')::NUMBER(10,2)), 1) as chomage_15_24,
    round(avg(REPLACE("25-49 ans", ',', '.')::NUMBER(10,2)), 1) as chomage_25_49,
    round(avg(REPLACE("50 ans ou plus", ',', '.')::NUMBER(10,2)), 1) as chomage_50_plus,
    round(avg(REPLACE(Ensemble, ',', '.')::NUMBER(10,2)), 1) as chomage_ensemble
from {{ source('data_analysis', 'insee_chomage_age')}}
where Annee between 2022 and 2025
group by Annee