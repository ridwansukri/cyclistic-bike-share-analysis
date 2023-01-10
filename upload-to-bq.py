# Create a copy of dataframe
clean_bike_to_bq = clean_bike.copy()

# Bigquery doesn't recognize category types, change several columns to string
clean_bike_to_bq = convert_to_string(clean_bike_to_bq, ['bike_type', 'customer_type'])

# Set environment variables
os.environ['GOOGLE_APPLICATION_CREDENTIALS'] = 'C:/Users/aspir/Desktop/Divvy/acoustic-portal-322707-496a5c838490.json'

def create_dataset(dataset_id, region_name):
    """Create a dataset in Google BigQuery if it does not exist.

    :param dataset_id: Name of dataset
    :param region_name: Region name for data center, i.e. europe-west2 for London
    :return: Create dataset
    """

    client = bigquery.Client()
    reference = client.dataset(dataset_id)

    try:
        client.get_dataset(reference)
    except NotFound:
        dataset = bigquery.Dataset(reference)
        dataset.location = region_name

        dataset = client.create_dataset(dataset)

create_dataset('bike_dataset','us-east1')

#pandas dataframe parameter
def insert(df, table):
    """
    :param df: Name of Pandas dataframe
    :param table: Name of BigQuery dataset and table, i.e. final_bike
    :return: BigQuery job object
    """

    client = bigquery.Client()

    return client.load_table_from_dataframe(df, table)

job = insert(clean_bike_to_bq, 'acoustic-portal-322707.bike_dataset.final_bike_df')
