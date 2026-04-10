with data_preparee as (
    select 
        Annee,
        Femmes,
        Hommes,
        Ensemble
    from {{ ref('stg_insee_chomage_genre')}}
),

unpivoted_genre as (
    select
        Annee,
        genre,
        taux_chomage_genre
    from data_preparee
    unpivot (
        taux_chomage_genre for genre in (Femmes, Hommes, Ensemble) 
    )
)

select 
    Annee,
    genre,
    round(avg(taux_chomage), 2) as taux_moyen_annuel
from unpivoted_genre
group by Annee, genre