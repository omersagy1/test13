import csv
import json
import os
import random
from typing import List, Text

import flask
from flask import Flask
from flask import render_template


APP_ROOT = os.path.dirname(os.path.abspath(__file__))
STATIC_PATH = os.path.join(APP_ROOT, 'static')
DATA_PATH = os.path.join(STATIC_PATH, 'data')

STATE_NAMES_PATH = os.path.join(DATA_PATH, 'states.txt')
CITIES_CSV_PATH = os.path.join(DATA_PATH, 'uscities.csv')


app = Flask(__name__)


@app.route('/')
def index():
    return render_template(
        'index.html', 
        title='Flask-made Title',
        states=get_states(),
        counties=county_names()
        )


@app.route('/api/random/state')
def api_random_state():
    response = flask.jsonify({
        'state': random_state()
    })
    return response


@app.route('/api/random/county')
def api_random_county():
    response = flask.jsonify({
        'county': random_county()
    })
    return response


def random_state():
    return random.choice(get_states())


def get_states() -> List[Text]:
    return open(STATE_NAMES_PATH).read().splitlines()


def random_county():
    return random.choice(list(county_names()))


def county_names():
    counties = set()
    with open(CITIES_CSV_PATH, newline='') as csvfile:
        city_reader = csv.reader(csvfile)
        for city in city_reader:
            counties.add(city[5])
    return counties
