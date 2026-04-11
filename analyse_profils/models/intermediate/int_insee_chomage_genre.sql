with stg_genre as (
    select * from {{ ref('stg_insee_chomage_genre') }}
),

unpivoted_genre as (
    select
        annee,
        genre,
        taux_chomage_genre
    from stg_genre
    UNPIVOT (
        taux_chomage_genre for genre in (F, M, unknown) 
    )
)

select 
    annee,
    genre, 
    ROUND(AVG(taux_chomage_genre), 2) as taux_chomage_genre
from unpivoted_genre
group by 
    annee, 
    genre