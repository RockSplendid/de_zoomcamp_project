{{
    config(
        materialized='view'
    )
}}

with 

source as (

    select * from {{ source('staging', 'test_results') }}

),

renamed as (

    select
        testdate,
        cast(lastupdated as timestamp) as lastupdated,

        statecode,

        cast(positive as numeric) as positive,
        cast(probablecases as numeric) as probablecases,
        cast(negative as numeric) as negative,
        cast(pending as numeric) as pending,
        cast(totaltestresults as numeric) as totaltestresults,
        cast(hospitalizedcurrently as numeric) as hospitalizedcurrently,
        cast(hospitalizedcumulative as numeric) as hospitalizedcumulative,
        cast(inicucurrently as numeric) as inicucurrently,
        cast(inicucumulative as numeric) as inicucumulative,
        cast(onventilatorcurrently as numeric) as onventilatorcurrently,
        cast(onventilatorcumulative as numeric) as onventilatorcumulative,
        cast(recovered as numeric) as recovered,
        
        cast(death as numeric) as death,
        cast(hospitalized as numeric) as hospitalized,
        cast(hospitalizeddischarged as numeric) as hospitalizeddischarged,
        cast(totaltestsviral as numeric) as totaltestsviral,
        cast(positivetestsviral as numeric) as positivetestsviral,
        cast(negativetestsviral as numeric) as negativetestsviral,
        cast(positivecasesviral as numeric) as positivecasesviral,
        cast(deathconfirmed as numeric) as deathconfirmed,
        cast(deathprobable as numeric) as deathprobable,
        cast(totaltestencountersviral as numeric) as totaltestencountersviral,
        cast(totaltestspeopleviral as numeric) as totaltestspeopleviral,
        cast(totaltestsantibody as numeric) as totaltestsantibody,
        cast(positivetestsantibody as numeric) as positivetestsantibody,
        cast(negativetestsantibody as numeric) as negativetestsantibody,
        cast(totaltestspeopleantibody as numeric) as totaltestspeopleantibody,
        cast(positivetestspeopleantibody as numeric) as positivetestspeopleantibody,
        cast(negativetestspeopleantibody as numeric) as negativetestspeopleantibody,
        cast(totaltestspeopleantigen as numeric) as totaltestspeopleantigen,
        cast(positivetestspeopleantigen as numeric) as positivetestspeopleantigen,
        cast(totaltestsantigen as numeric) as totaltestsantigen,
        cast(positivetestsantigen as numeric) as positivetestsantigen,
        cast(fips as numeric) as fips,
        cast(positiveincrease as numeric) as positiveincrease,
        cast(negativeincrease as numeric) as negativeincrease,
        cast(total as numeric) as total,
        cast(totaltestresultsincrease as numeric) as totaltestresultsincrease,
        
        cast(deathincrease as numeric) as deathincrease,
        cast(hospitalizedincrease as numeric) as hospitalizedincrease--,
        --hash as record_hash

        -- the below columns are dropped since they are all zero
        -- dataqualitygrade, negativeregularscore, 
        -- negativescore, positivescore, score

    from source

)

select * from renamed
