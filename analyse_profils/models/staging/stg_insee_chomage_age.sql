select 
    Annee,
    Trimestre,
    REPLACE("15-24 ans", ',', '.')::NUMBER(10,2) as taux_15_24,
    REPLACE("25-49 ans", ',', '.')::NUMBER(10,2) as taux_25_49,
    REPLACE("50 ans ou plus", ',', '.')::NUMBER(10,2) as taux_50_plus,
    REPLACE(Ensemble, ',', '.')::NUMBER(10,2) as taux_ensemble_age
from {{ source('data_analysis', 'insee_chomage_age')}}
where Annee between 2022 and year(current_date())