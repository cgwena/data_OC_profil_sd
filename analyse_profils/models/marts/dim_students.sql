with students as (
    select * from {{ ref('stg_students_info')}}
),
insee_chomage_age as (
    select * from {{ ref('int_insee_chomage_age')}}
),
insee_chomage_genre as (
    select * from {{ ref('int_insee_chomage_genre')}}
),
insee_chomage_region as (
    select * from {{ ref('int_insee_chomage_region')}}
),

students_profils_sd as (
    select
        s.student_year_id,
        s.user_id,
        s.path_category_name,
        s.oc_age_group,
        s.insee_age_group,
        s.gender,
        s.region,
        s.year_path_started,

        a.taux_chomage_age as taux_chomage_age,
        g.taux_chomage_genre as taux_chomage_genre,
        r.taux_chomage_region as taux_chomage_region

    from students s 
    left join insee_chomage_age a 
        on s.year_path_started = a.annee 
        and s.insee_age_group = a.age
    left join insee_chomage_genre g 
        on s.year_path_started = g.annee
        and upper(s.gender) = upper(g.genre)
    left join insee_chomage_region r
        on s.year_path_started = r.annee
        and s.region = r.nom_region
)

select * from students_profils_sd