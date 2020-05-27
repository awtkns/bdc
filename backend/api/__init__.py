from flask import Flask
from flask import request
from flask_cors import CORS
import pandas as pd

from .data import analysis

app = Flask(__name__)
CORS(app, resources={r'/*': {'origins': '*'}})

datasets = analysis.get_datasets()
slugs = [{'slug': str(key), 'title': datasets[key]['title']} for key in datasets.keys()]


@app.route('/')
def get_available_dataset():
    return {'slugs': slugs}, 200


@app.route('/<slug>')
def get_dataset(slug):
    col = request.headers.get('col')
    data = datasets[str(slug)]
    if col == None:
        return data, 200

    # return just 1 column of the dataset
    df = pd.DataFrame(data)
    print(df.iloc[:,2])
    return data, 200

