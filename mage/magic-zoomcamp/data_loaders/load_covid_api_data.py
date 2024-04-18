import pandas as pd
import requests
import json

if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_api(*args, **kwargs):
    """
    Loading data from API
    """
    states_df = pd.read_csv('states.csv', header=0, index_col=2)
    df_final = pd.DataFrame()

    for state in states_df.index:
        url = f"https://api.covidtracking.com/v1/states/{state.lower()}/daily.json"
        
        response = requests.request("GET", url)

        df1 = pd.read_json(json.dumps(response.json(), indent=2))

        print(f"US-{state}'s daily data is fetched! >> {df1.shape[0]} rows")

        df_final = pd.concat([df_final, df1], ignore_index=True)
    
    return df_final


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'