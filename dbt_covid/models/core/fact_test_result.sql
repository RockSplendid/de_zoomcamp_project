{{
    config(
        materialized='table'
    )
}}

with test_results as (
    select *
    from {{ ref('stg_test_results') }}
),
states as (
    select *
    from {{ ref('dim_state') }}
    where statecode is not null
)

select testdate,
        lastupdated,
        states.statecode,
        test_results.fips,
        states.statename,
        states.population,
        `hash`,
        positive,                     
        positivecasesviral, 
        probablecases,       
        positiveincrease,    
        negativeincrease,
        negative,                                
        totaltestspeopleviral,         
        negativetestsviral,             
        pending,                                   
        positivetestsviral,            
        totaltestsviral,                  
        totaltestencountersviral,
        totaltestresults,
        totaltestresultsincrease,
        hospitalizedcumulative,
        hospitalizedcurrently,
        hospitalizedincrease,
        inicucumulative,             
        inicucurrently,                 
        onventilatorcumulative,
        onventilatorcurrently,   
        death,                                  
        deathconfirmed,                  
        deathprobable,                    
        hospitalizeddischarged,  
        deathincrease,              
        recovered,                            
        totaltestsantibody,
        positivetestsantibody,
        negativetestsantibody,
        totaltestspeopleantibody,
        positivetestspeopleantibody,
        negativetestspeopleantibody,
        totaltestspeopleantigen,
        positivetestspeopleantigen,
        totaltestsantigen,
        positivetestsantigen
from test_results
inner join states on states.fips=test_results.fips