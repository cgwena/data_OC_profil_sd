select 
    Annee,
    Trimestre,
    REPLACE(Femmes, ',', '.')::NUMBER(10,2) as taux_femmes,
    REPLACE(Hommes, ',', '.')::NUMBER(10,2) as taux_hommes,
    REPLACE(Ensemble, ',', '.')::NUMBER(10,2) as taux_ensemble_genre
from {{ source('data_analysis', 'insee_chomage_genre')}}
where Annee between 2022 and year(current_date())