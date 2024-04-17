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
        cast(lastupdated as timestamp) as lastupdated, -- Last Update (Eastern Time)
        statecode,
        cast(fips as numeric) as fips,
        `hash`,



        ---------- Cases
        cast(positive as numeric) as positive,                     -- Cases (confirmed plus probable)
        cast(positivecasesviral as numeric) as positivecasesviral, -- Confirmed Cases
        cast(probablecases as numeric) as probablecases,           -- Probable Cases
        cast(positiveincrease as numeric) as positiveincrease,     -- New cases
        cast(negativeincrease as numeric) as negativeincrease,
        




        ---------- PCR Tests
        cast(negative as numeric) as negative,                                 -- Negative PCR tests (people)
        cast(totaltestspeopleviral as numeric) as totaltestspeopleviral,       -- Total PCR tests (people)        
        cast(negativetestsviral as numeric) as negativetestsviral,             -- Negative PCR tests (specimens)
        cast(pending as numeric) as pending,                                   -- Pending viral tests
        cast(positivetestsviral as numeric) as positivetestsviral,             -- Positive PCR tests (specimens)
        cast(totaltestsviral as numeric) as totaltestsviral,                   -- Total PCR tests (specimens)
        cast(totaltestencountersviral as numeric) as totaltestencountersviral, -- Total PCR tests (test encounters)

        ---------------------------------------------------
        ----------------- Better not used -----------------
        cast(totaltestresults as numeric) as totaltestresults,                 -- Total test results estimate all over US
        cast(totaltestresultsincrease as numeric) as totaltestresultsincrease, -- Daily increase in totalTestResults
        ----------------- Better not used -----------------
        ---------------------------------------------------





        ---------- Hospitalization
        cast(hospitalizedcumulative as numeric) as hospitalizedcumulative, -- Cumulative hospitalized/Ever hospitalized
        cast(hospitalizedcurrently as numeric) as hospitalizedcurrently,   -- Currently hospitalized/Now hospitalized
        cast(hospitalizedincrease as numeric) as hospitalizedincrease,     -- New total hospitalizations

        cast(inicucumulative as numeric) as inicucumulative,               -- Cumulative in ICU/Ever in ICU
        cast(inicucurrently as numeric) as inicucurrently,                 -- Currently in ICU/Now in ICU

        cast(onventilatorcumulative as numeric) as onventilatorcumulative, -- Cumulative on ventilator/Ever on ventilator
        cast(onventilatorcurrently as numeric) as onventilatorcurrently,   -- Currently on ventilator/Now on ventilator


        
        
        ---------- Outcomes
        cast(death as numeric) as death,                                    -- Deaths (confirmed and probable)
        cast(deathconfirmed as numeric) as deathconfirmed,                  -- Deaths (confirmed)
        cast(deathprobable as numeric) as deathprobable,                    -- Deaths (probable)
        cast(hospitalizeddischarged as numeric) as hospitalizeddischarged,  -- Hospital discharges
        cast(deathincrease as numeric) as deathincrease,                    -- New deaths
        cast(recovered as numeric) as recovered,                            -- Recovered      
        
        

        
        ---------- Antibody Tests
        cast(totaltestsantibody as numeric) as totaltestsantibody,                   -- Total antibody tests (specimens)
        cast(positivetestsantibody as numeric) as positivetestsantibody,             -- Positive antibody tests (specimens)
        cast(negativetestsantibody as numeric) as negativetestsantibody,             -- Negative antibody tests (specimens)

        cast(totaltestspeopleantibody as numeric) as totaltestspeopleantibody,       -- Total antibody tests (people)
        cast(positivetestspeopleantibody as numeric) as positivetestspeopleantibody, -- Positive antibody tests (people)
        cast(negativetestspeopleantibody as numeric) as negativetestspeopleantibody, -- Negative antibody tests (people)




        ---------- Antigen Tests
        cast(totaltestspeopleantigen as numeric) as totaltestspeopleantigen,       -- Total antigen tests (people)
        cast(positivetestspeopleantigen as numeric) as positivetestspeopleantigen, -- Positive antigen tests (people)

        cast(totaltestsantigen as numeric) as totaltestsantigen,                   -- Total antigen tests (specimens)
        cast(positivetestsantigen as numeric) as positivetestsantigen             -- Positive antigen tests (specimens)


        

        -- the below columns are dropped since they are all zero
        -- hospitalized, total, dataqualitygrade, negativeregularscore, 
        -- negativescore, positivescore, score

    from source

)

select * from renamed


-- dbt build --select <model_name> --vars '{'is_test_run': 'false'}'
{% if var('is_test_run', default=true) %}

  limit 100

{% endif %}