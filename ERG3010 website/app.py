from flask import Flask, Response, request, jsonify
from os import path
app = Flask(__name__, static_url_path = "", static_folder = "")
app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0 # No cache, so the website is updated in every refresh.

fake = [
    [1, 2, 3, 4, 5, 6],
    [15, 20, 3, 40, 5, 60],
    [20, 23, 10, 49, 23, 1],
    [100, 2, 30, 23, 54, 64],
    [72, 64, 36, 20, 92, 9], 
]

@app.route('/')
def index():
    return app.send_static_file("index.html")

@app.route('/fake_data/<int:id>')
def fake_data(id):
    id = max(0, id)
    id = min(4, id)
    return jsonify(fake[id])


if __name__ == '__main__':
    app.run(threaded = True, debug = True)