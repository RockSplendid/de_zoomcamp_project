from mage_ai.settings.repo import get_repo_path
from mage_ai.io.config import ConfigFileLoader
from mage_ai.io.postgres import Postgres
from os import path
if 'data_loader' not in globals():
    from mage_ai.data_preparation.decorators import data_loader
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@data_loader
def load_data_from_postgres(*args, **kwargs):
    """
    Template for loading data from a PostgreSQL database.
    Specify your configuration settings in 'io_config.yaml'.

    Docs: https://docs.mage.ai/design/data-loading#postgresql
    """
    test_results = '''SELECT testdate, statecode, positive, probablecases, negative, pending, \
    totaltestresults, hospitalizedcurrently, hospitalizedcumulative, inicucurrently, inicucumulative, \
    onventilatorcurrently, onventilatorcumulative, recovered, lastupdated, death, hospitalized, \
    hospitalizeddischarged, totaltestsviral, positivetestsviral, negativetestsviral, positivecasesviral, \
    deathconfirmed, deathprobable, totaltestencountersviral, totaltestspeopleviral, totaltestsantibody, \
    positivetestsantibody, negativetestsantibody, totaltestspeopleantibody, positivetestspeopleantibody, \
    negativetestspeopleantibody, totaltestspeopleantigen, positivetestspeopleantigen, totaltestsantigen, \
    positivetestsantigen, fips, positiveincrease, negativeincrease, total, totaltestresultsincrease, \
    dataqualitygrade, deathincrease, hospitalizedincrease, hash, negativeregularscore, \
    negativescore, positivescore, score \
                     FROM magic.dailytestresults;'''
     
    config_path = path.join(get_repo_path(), 'io_config.yaml')
    config_profile = 'dev'

    with Postgres.with_config(ConfigFileLoader(config_path, config_profile)) as loader:
        return loader.load(test_results)


@test
def test_output(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert output is not None, 'The output is undefined'
