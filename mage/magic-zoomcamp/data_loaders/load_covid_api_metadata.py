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
    url = "https://api.covidtracking.com/v2/states.json"

    response = requests.request("GET", url)
    
    with open('states_data.json','w') as json_file:
        json.dump(response.json()['data'], json_file)

    with open('states_data.json','r') as file:
        data = json.loads(file.read())

        pd.json_normalize(data).to_csv('states.csv')
    print("The metadata is written into a csv file!")

    return pd.json_normalize(data)


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'