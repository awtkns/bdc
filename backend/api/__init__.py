from flask import Flask
from flask import request
from flask_cors import CORS
import pandas as pd
import numpy as np

from .data import analysis

app = Flask(__name__)
CORS(app, resources={r'/*': {'origins': '*'}})

dataframes, datasets = analysis.get_datasets()
slugs = [{'slug': str(key), 'title': datasets[key]['title']} for key in datasets.keys()]

colours = []
for _ in range(1000):
    colour = str(list(np.random.choice(range(256), size=3))).replace("[", "rgb(").replace("]", ")")
    colours.append(colour)


@app.route('/')
def get_available_dataset():
    return {'slugs': slugs}, 200


@app.route('/dataset/<slug>')
def get_dataset(slug):
    return datasets[str(slug)], 200
    

@app.route('/barChartData/<slug>')
def get_barChart(slug):

    slug = 2  # TODO: !TEMPORARY! make it work with the other datasets lol

    col = request.headers.get('col')
    df = dataframes[str(slug)].loc[:, col]

    # TODO: don't throw a fit if there's bad data in [countries] (ie, the user types something random)
    countries = request.headers.get('countries')[1:-1].replace('"', "").split(',')
    df = df.loc[countries]

    labels = df.index.values.tolist()
    label = df.name
    
    data = df.values.tolist()

    # TODO: pre-process this for efficiency
    for i in range(len(data)):
        if np.isnan(data[i]):
            data[i] = 0 

    chartData = {
        'labels': labels,
        'datasets': [
            {
                'label': label,
                'data': data,
                'backgroundColor': colours[:len(data)]
            }
        ]
    }

    return chartData, 200

