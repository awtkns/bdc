from flask import Flask
from flask import request
from flask_cors import CORS
import pandas as pd
import numpy as np

from .data import analysis

app = Flask(__name__)
CORS(app, resources={r'/*': {'origins': '*'}})

datasetNames, datasets, dataframes = analysis.get_datasets()

colours = []
for _ in range(1000):
    colour = str(list(np.random.choice(range(256), size=3))).replace("[", "rgb(").replace("]", ")")
    colours.append(colour)


@app.route('/datasetNames')
def get_datasetNames():
    return datasetNames, 200


@app.route('/dataset/<datasetName>')
def get_dataset(datasetName):
    return datasets[datasetName], 200


def chart_format(df, transpose=False):
    if transpose:
        df = df.transpose()
        df = df.sort_values(by=df.index[0], axis=1, ascending=False)
    else:
        df = df.sort_values(by=df.columns[0], ascending=False)

    data_dict = df.to_dict(orient='list')
    datasets = []
    for label, values in data_dict.items():
        datasets.append({
            'label': label,
            'data': values,
        })

    chart_data = {
        'labels': list(df.index),
        'datasets': datasets
    }

    return chart_data


@app.route('/barChartData/<datasetName>', methods=['PUT'])
def get_bar_chart(datasetName):
    df = None
    transpose = request.json['transpose']

    # Countries
    if str(datasetName) == 'grouped_master_dev_level':
        cols = request.json['cols']
        countries = request.json['countries']

        df = dataframes[datasetName].loc[:, cols]
        df = df.loc[countries]
        df = df.fillna(0)

    # Quartile Chart
    elif str(datasetName) == 'imaging_units_per_1M_by_development_quartile':
        df = dataframes[datasetName]

    return chart_format(df, transpose), 200

@app.route('/lineChartData/<datasetName>', methods=['PUT'])
def get_line_chart(datasetName):
    df = None
    transpose = request.json['transpose']

    df = dataframes[datasetName]

    return chart_format(df, transpose), 200

@app.route('/scatterChartData/<datasetName>', methods=['PUT'])
def get_scatter_chart(datasetName):

    df = dataframes[datasetName]
    df = df.set_index(['year'], append=True)
    df = df.iloc[:, 1:]

    df = df.fillna(0)
    print(df)

    return 'ok'
    # return data_dict


