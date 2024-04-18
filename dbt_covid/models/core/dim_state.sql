{{
    config(
        materialized='table'
    )
}}

with 

source as (

    select * from {{ source('core', 'states') }}

),

renamed as (

    select
        statename, 
        statecode, 
        cast(fips as numeric) as fips, 
        sites, 
        population, 
        totaltestfield, 
        totaltestunit

    from source

)

select * from renamed
