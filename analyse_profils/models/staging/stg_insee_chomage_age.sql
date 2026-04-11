select 
    Annee,
    Trimestre,
    {{ replace_comma('"15-24 ans"')}} as "15-24 ans",
    {{ replace_comma('"25-49 ans"')}} as "25-49 ans",
    {{ replace_comma('"50 ans ou plus"')}}as "50 ans ou plus",
    {{ replace_comma('Ensemble')}} as Ensemble
from {{ source('data_analysis', 'insee_chomage_age')}}
where Annee >= 2022