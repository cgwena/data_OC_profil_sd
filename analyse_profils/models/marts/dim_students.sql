with students as (
    select * from {{ ref('stg_students_info')}}
),
insee_chomage_age as (
    select * from {{ ref('int_insee_chomage_age')}}
),
insee_chomage_genre as (
    select * from {{ ref('int_insee_chomage_genre')}}
),

students_profils_sd as (
    select
        s.student_year_id,
        s.user_id,
        s.path_category_name,
        s.insee_age_group,
        s.gender,
        s.region,
        s.year_path_started,

        case 
            when s.insee_age_group = '15-24 ans' then a.chomage_15_24
            when s.insee_age_group = '25-49 ans' then a.chomage_25_49
            when s.insee_age_group = '50 ans ou plus' then a.chomage_50_plus
        end as taux_chomage_age,

        case 
            when s.gender = 'F' then g.chomage_femmes
            when s.gender = 'M' then g.chomage_hommes
            WHEN s.gender = 'unknown' then g.chomage_ensemble_genre
        end as taux_chomage_genre,

    from students s 
    left join insee_chomage_age a 
        on s.year_path_started = a.annee 
    left join insee_chomage_genre g 
        on s.year_path_started = g.annee
)

select * from students_profils_sd