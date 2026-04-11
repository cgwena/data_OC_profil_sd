with stg_chomage_region as (
    select * from {{ ref('stg_insee_chomage_region') }}
),

unpivoted_data as (
    select 
        code_region,
        nom_region,
        periode,
        taux_chomage_region
    from stg_chomage_region
    unpivot (
        taux_chomage_region FOR periode IN (
            t1_2022, t2_2022, t3_2022, t4_2022,
            t1_2023, t2_2023, t3_2023, t4_2023,
            t1_2024, t2_2024, t3_2024, t4_2024,
            t1_2025, t2_2025, t3_2025, t4_2025
        )
    )
)

select 
    code_region,
    nom_region,
    right(periode, 4)::int as annee,
    round(AVG(taux_chomage_region), 2) as taux_chomage_region
from unpivoted_data
where annee >= 2022
group by 
    code_region,
    nom_region,
    annee