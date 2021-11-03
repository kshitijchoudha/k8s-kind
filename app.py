from flask import Flask
app = Flask(__name__)

@app.route('/hello')
def hello_world():
    return 'Hello, k8s!!!'

@app.route('/')
def hello_root():
    return 'Hello!'