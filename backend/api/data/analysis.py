import os
import pandas as pd
import json

from inflection import humanize


def read_csv(fp):
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


def get_datasets():
    web_dir = os.path.join(os.path.dirname(__file__), 'web_ready')

    datasets = {}
    for (slug, f_name) in enumerate(os.listdir(web_dir)):
        fp = os.path.join(web_dir, f_name)
        df = read_csv(fp)
        print(slug)
        datasets[str(slug)] = {
            'title': humanize(f_name.strip('.csv')),
            'table': df_to_datatable(df)
        }

    return datasets
