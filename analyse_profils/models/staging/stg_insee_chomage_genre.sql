select 
    Annee,
    Trimestre,
    {{replace_comma('Femmes')}} AS Femmes,
    {{replace_comma('Hommes')}} AS Hommes,
    {{replace_comma('Ensemble')}} AS Ensemble
from {{ source('data_analysis', 'insee_chomage_genre')}}
where Annee between 2022 and year(current_date())