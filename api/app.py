from flask import Flask
from flask_cors import CORS

from api.data import analysis

app = Flask(__name__)
CORS(app, resources={r'/*': {'origins': '*'}})


@app.route('/')
def hello_world():
    return analysis.dump()
