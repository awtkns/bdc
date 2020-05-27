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

    # TODO: return the 1st and the 'col'th column of the dataset
    df = pd.DataFrame([['Afghanistan', 0.2, 0.1], ['Albania', 5.36, 1.58], ['Algeria', 0, 0]], columns = ['Country', 'Computed Tomography', 'MRI'])
    print(pd.DataFrame([df.iloc[:, 0], df.iloc[:, 2]], columns=['Country', 'MRI']))

    labels = df.iloc[:, 0].to_string()
    label = "MRI"
    data = df.iloc[:, 2].to_string()



    "{labels: %s,datasets: [{label: %s,data: %s}]}" % (labels, label, data)
    # backgroundColor: ["red", "orange", "yellow"]

    print("{labels: %s,datasets: [{label: %s,data: %s}]}" % (labels, label, data))
    return data, 200

