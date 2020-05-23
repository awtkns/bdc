import os
import pandas as pd
import json


def dump():
    return df_to_datatable(read_csv())


def describe():
    df = read_csv()
    df = df.append(df.describe())
    return df.loc[:, '2000':]


def read_csv():
    fp = os.path.join(os.path.dirname(__file__), 'breast_cancer_new_cases_per_100000_women.csv')
    df = pd.read_csv(fp)
    df.index = df['country']
    df.drop(columns=['country'], inplace=True)
    return df


def df_to_datatable(df):
    df = df.loc[:, '2000':]
    df = df.append(df.describe())
    df_dict = json.loads(df.to_json(orient='table', double_precision=3))

    return {
        'items': df_dict['data'],
        'headers': get_headers(df_dict['schema']['fields']),
        'title': 'New Breast Cancer Case per 100k women',
    }


def get_headers(fields: dict):
    return [{'text': f['name'], 'value': f['name']} for f in fields]
