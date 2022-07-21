#!flask/bin/python
from flask import Flask, jsonify

app = Flask(__name__)

tasks = [
    {
        'id': 1,
        'title': u'Learn Kubernetes!!',
        'description': u'Woah, that is a pod', 
        'done': True
    },
    {
        'id': 2,
        'title': u'Learn Docker',
        'description': u'Hm! I love this Dockerfile', 
        'done': True
    }
]

@app.route('/todo/api/v1.0/tasks', methods=['GET'])
def get_tasks():
    return jsonify({'tasks': tasks})

@app.route("/")
def home():
    return "This is a simple API, try to GET /todo/api/v1.0/tasks!"

if __name__ == '__main__':
    app.run(host='0.0.0.0')
