# The COVID Tracking Project

### Objective:

The goal of this project is to apply the things we have learned in [Data Engineering Zoomcamp](https://github.com/DataTalksClub/data-engineering-zoomcamp) to build an end-to-end data pipeline. This is done as the capstone project of the zoomcamp cohort 2024.

## Problem Statement:

The dataset used for this project is the [COVID tracking project](https://covidtracking.com/data), which collected and published the most complete testing data available for US states and territories. As the name suggests, it was tracking the COVID statistics both in state and national level all over the US. 

Here, the data definitions are provided in detail: (https://covidtracking.com/about-data/data-definitions). They are also provided in metadata key in API responses.
The categories offered in the dataset are:
- Cases
- PCR Tests
- Antibody Tests
- Antigen Tests
- Hospitalization
- Outcomes
- State Metadata (*Note: FIPS codes are numbers which uniquely identify geographic areas.*)

*These are also explained in dbt SQL files*.

The data is available both as API and in csv format. The API is also available in 2 versions and the [fields conversion](https://covidtracking.com/data/api/version-2) between the two is provided. 

Here, the data is collected via the [API](https://covidtracking.com/data/api) and all the requests are made and tested in postman and Python.

**Notice:** *The COVID Tracking Project has ended all data collection as of March 7, 2021. The existing API will continue to work until May 2021, but will only include data up to March 7, 2021.*

## Data Pipeline:

The data pipeline has multiple steps and it runs in batch mode.
1. The data is fetched from API. *(**Python** is used here.)*
2. It is cleansed (on the basic level) and transferred to the data lake. *(**Postgres** is used as the data lake.)*
3. The data is loaded from the data lake to the data warehouse. *(**GCP** is used as the cloud solution and **BigQuery** is the data warehousing tool.)*

**All the above steps are orchestrated as a workflow in [Mage](https://docs.mage.ai/introduction/overview) and Mage, Postgres and pgAdmin are run on Docker**.

4. The transformations and data modeling are done with **dbt** via **dbt cloud**. Again, the data is loaded back into **BigQuery**.
5. The data is visualized in **Looker Studio**.

## Implementation:

After cloning the repo, change the directory to mage folder:

      cd mage

After creating the GCP account [here](https://cloud.google.com/?hl=en) and creating a service account in IAM & Admin section of the website, copy and paste the json file for GCP service account key in the above folder. (GCP account setup is also explained in this [repo](https://github.com/nenalukic/air-quality-project?tab=readme-ov-file#setting-up-gcp))

Using `Dockerfile` and `docker-compose.yml`, a container is built and run with 3 images: Mage, Postgres and pgAdmin:

      docker compose up -d

The volume for pgadmin can also be mounted in the `docker-compose.yml` file, like this: `volumes: - ./data_pgadmin:/var/lib/pgadmin`

After running the container, the Mage service is available on port `6789` and pgadmin on port `8080`. In pgadmin, the server can be created based on the data in the `docker-compose.yml` file and the config which can be created in `.env` file.

The pipelines can be found in `mage/magic-zoomcamp/pipelines` folder and the name of the blocks are mentioned in the `metadata.yaml` file. Also, the `.py` files which forms the pipelines in Mage are located in `data_loaders`, `transformers` and `data_exporters` folders.

#### Workflows:
Firstly, the `covid_api_metadata_to_postgres` pipeline fetches the metadata *(states table in postgres)* from the API and loads them into Postgres.

![1](https://github.com/RockSplendid/de_zoomcamp_project/assets/149693582/f24197d9-25b3-4844-b062-1defdf02ddd1)

Then, the `covid_api_data_to_postgres` pipeline fetches the COVID data *(dailytestresults table in postgres)* from the API and loads them into Postgres. **Note: the data for each state is extracted and concatenated with each other.**

![Screenshot 2024-04-18 213157](https://github.com/RockSplendid/de_zoomcamp_project/assets/149693582/d31fbd92-ba22-4154-ab32-133d0526c240)

Finally, the `load_data_from_postgres_to_bigquery` pipeline transfers the data from Postgres as the data lake into BigQuery as the data warehouse.
 
![3](https://github.com/RockSplendid/de_zoomcamp_project/assets/149693582/27866b52-3e77-4253-8131-07f83e152cb7)

### Transformations and Data Modeling:

All the steps as depicted below, exist in the `dbt_covid/models` folder.

![Screenshot 2024-04-17 190714](https://github.com/RockSplendid/de_zoomcamp_project/assets/149693582/3949016a-cb86-42fc-8e7d-c5a252f3e5de)

The whole model and the dependent `.sql` files can be built and run with `dbt build` and `dbt run`, respectively.


## Looker Dashboard:
After the transformations made in dbt, *fact_test_result* table is connected to Looker via Google BigQuery connector and the dashboard is designed based on various metrics.

[COVID Dashboard](https://lookerstudio.google.com/s/lxHCFARo1Ec)

*Update 2026: Sorry, it seems the report on Looker ran into some credentials error and I cannot access it to fix the issue.*
