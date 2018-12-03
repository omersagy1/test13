import csv
import json
import math
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
CITY_POPS_CSV_PATH = os.path.join(DATA_PATH, 'city_stats.csv')


app = Flask(__name__)


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/api/random/county')
def api_random_county():
    response = flask.jsonify({
        'county': random_county()
    })
    return response


@app.route('/api/city')
def api_query_city():
    population_query: int = int(flask.request.args.get('pop'))

    min_dist = math.inf
    min_city: (Text, Text, int) = None

    with open(CITY_POPS_CSV_PATH, newline='') as csvfile:
        city_reader = csv.reader(csvfile)
        for city in city_reader:
            if city[2].isdigit():
                dist = abs(population_query - int(city[2]))
                if dist < min_dist:
                    min_dist = dist
                    min_city = (city[0], city[1], int(city[2]))

    response = flask.jsonify({
        'city': min_city[0],
        'state': min_city[1],
        'population': min_city[2]
    })

    print(min_city[0])

    return response


def random_county():
    return random.choice(list(county_names()))


def county_names():
    counties = set()
    with open(CITIES_CSV_PATH, newline='') as csvfile:
        city_reader = csv.reader(csvfile)
        for city in city_reader:
            counties.add(city[5])
    return counties
