if 'transformer' not in globals():
    from mage_ai.data_preparation.decorators import transformer
if 'test' not in globals():
    from mage_ai.data_preparation.decorators import test


@transformer
def transform(data, *args, **kwargs):
    """
    Clean the names of the columns
    """

    data = data.drop(columns=['totalTestResultsSource','lastUpdateEt','checkTimeEt'
    ,'dateChecked', 'grade','posNeg','commercialScore'], axis=1)
    data = data.rename(columns={'date' : 'testDate', 'state' : 'stateCode', 'dateModified' : 'lastUpdated'})

    return data


@test
def test_output_column(output, *args) -> None:
    """
    Template code for testing the output of the block.
    """
    assert 'stateCode' in output.columns, 'The stateCode column is not present in the data.'
