from flask import Flask
from flask_cors import CORS

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
    print(datasets.keys())
    return datasets[str(slug)], 200

