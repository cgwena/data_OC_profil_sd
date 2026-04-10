select 
    Annee,
    Trimestre,
    {{ replace_comma('"15-24 ans"')}} as taux_15_24,
    {{ replace_comma('"25-49 ans"')}} as taux_25_49,
    {{ replace_comma('"50 ans et plus"')}}as taux_50_plus,
    {{ replace_comma('Ensemble')}} as taux_ensemble_age
from {{ source('data_analysis', 'insee_chomage_age')}}
where Annee between 2022 and year(current_date())