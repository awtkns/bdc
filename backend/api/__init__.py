from flask import Flask
from flask import request
from flask_cors import CORS
import pandas as pd
import numpy as np
import json

from .data import analysis

app = Flask(__name__)
CORS(app, resources={r'/*': {'origins': '*'}})

datasetNames, datasets, dataframes = analysis.get_datasets()

colours = []
for _ in range(1000):
    colour = str(list(np.random.choice(range(256), size=3))).replace("[", "rgb(").replace("]", ")")
    colours.append(colour)

with open('api/data/bibliography/bibliography.json') as f:
  citations = json.load(f)

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
    if str(datasetName) == 'grouped_master':
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

    # Countries
    if str(datasetName) == 'country_year_master':
        countries = request.json['countries']
        cols = request.json['cols']
        dependentVar = cols[0]
        
        colsplus = cols
        colsplus.append("year")

        df = dataframes[datasetName].loc[:, colsplus]
        df = pd.pivot_table(df, index=['country'], columns= "year", values=dependentVar, aggfunc=np.sum, fill_value=0)
        df.reset_index()
        df = df.loc[countries]
        df = df.fillna(0)

    ret = chart_format(df, transpose)

    print(ret)

    return ret, 200

@app.route('/scatterChartData/<datasetName>', methods=['PUT'])
def get_scatter_chart(datasetName):

    df = dataframes[datasetName]
    df = df.set_index(['year'], append=True)
    df = df.iloc[:, 1:]

    df = df.fillna(0)
    print(df)

    return 'ok'
    # return data_dict

@app.route('/citations')
def get_citations():
    return citations, 200


