with 

source as (

    select * from {{ source('data_analysis', 'insee_chomage_age') }}

),

renamed as (

    select
        annee,
        trimestre,
        15-24 ans,
        25-49 ans,
        50 ans ou plus,
        ensemble

    from source

)

select * from renamed