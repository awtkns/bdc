import os
import pandas as pd
import json

from inflection import humanize


def read_csv(fp):
    df = pd.read_csv(fp)
    df.index = df[df.columns[0]]
    df = df.drop(df.columns[0], axis=1)

    return df


def df_to_datatable(df):
    try:
        df = df.loc[:, '2000':]
    except KeyError:
        pass

    # df = df.append(df.describe())
    df_dict = json.loads(df.to_json(orient='table', double_precision=3))

    return {
        'items': df_dict['data'],
        'headers': get_headers(df_dict['schema']['fields']),
        'title': 'New Breast Cancer Case per 100k women'
    }


def get_headers(fields: dict):
    return [{'text': f['name'], 'value': f['name']} for f in fields]


def get_datasets():
    web_dir = os.path.join(os.path.dirname(__file__), 'web_ready')

    datasetNames = {}
    dataframes = {}
    datasets = {}

    for (i, f_name) in enumerate(os.listdir(web_dir)):
        fp = os.path.join(web_dir, f_name)

        if fp.endswith('.csv'):
            datasetName = f_name.replace(".csv", "")
            df = read_csv(fp)

            if datasetName == "country_year_master":
                df = df[["year","Existence of national screening program for breast cancer","Existence of national screening program for cervical cancer","Existence of national HPV vaccination programme","Current health expenditure (CHE) as percentage of gross domestic product (GDP) (%)","Current health expenditure (CHE) per capita in PPP int$","Current health expenditure (CHE) per capita in US$","Out-of-pocket expenditure (OOP) per capita in PPP int$","Out-of-pocket expenditure (OOP) per capita in US$","Breast cancer deaths per 100000 women","Breast cancer new cases per 100000 women","Gdp pc usd inflation adjusted","Gni pc constant 2010 u","Prostate cancer deaths per 100000 men","Prostate cancer new cases per 100000 men"]]

            datasetNames[i] = datasetName
            dataframes[datasetName] = df
            datasets[datasetName] = {
                'title': humanize(datasetName),
                'table': df_to_datatable(df),
                'columns': df.columns.values.tolist(),
                'indices': df.index.values.tolist()
            }
            
    return (datasetNames, datasets, dataframes)
