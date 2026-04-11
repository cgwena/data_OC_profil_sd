select 
    Annee,
    Trimestre,
    {{ replace_comma('Femmes')}} as F,
    {{ replace_comma('Hommes')}} as M,
    {{ replace_comma('Ensemble')}} as unknown,
from {{ source('data_analysis', 'insee_chomage_genre')}}
where Annee >= 2022