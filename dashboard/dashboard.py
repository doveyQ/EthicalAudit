from flask import Flask, render_template
import matplotlib.pyplot as plt
import io
import base64
from datetime import datetime
import re

app = Flask(__name__)

log_file_path = 'logfile.txt'
timestamps_get = []
timestamps_post = []

# Regular expression pattern to match the timestamp
pattern = r'\[([\w:/]+\s[+\-]\d{4})\]'

with open(log_file_path, 'r') as file:
    for line in file:
        match = re.search(pattern, line)
        if match:
            timestamp = match.group(1)
            if 'GET /example ' in line:
                print(line)
                timestamps_get.append(timestamp)
            elif 'GET /example?rid' in line:
                print(line)
                timestamps_get.append(timestamp)
            elif 'POST /login HTTP/1.1' in line:
                print(line)
                timestamps_post.append(timestamp)

counts_get = {}
counts_post = {}

for timestamp in timestamps_get:
    # Parse the timestamp into a datetime object
    dt = datetime.strptime(timestamp, '%d/%b/%Y:%H:%M:%S %z')

    # Extract the date part from the datetime object
    date = dt.date()

    # Increment the count for the corresponding date in the get dictionary
    counts_get[date] = counts_get.get(date, 0) + 1

for timestamp in timestamps_post:
    dt = datetime.strptime(timestamp, '%d/%b/%Y:%H:%M:%S %z')
    date = dt.date()
    counts_post[date] = counts_post.get(date, 0) + 1

fig, ax = plt.subplots()

dates = sorted(set(list(counts_get.keys()) + list(counts_post.keys())))

# Create lists for the count values of both GET and POST requests
count_values_get = [counts_get.get(date, 0) for date in dates]
count_values_post = [counts_post.get(date, 0) for date in dates]

# Plot the data
ax.plot(dates, count_values_get, label='GET Requests')
ax.plot(dates, count_values_post, label='POST Requests')
ax.set_xlabel('Timestamp')
ax.set_ylabel('Count')
ax.set_title('Timestamp Counts')
plt.xticks(rotation=45)
plt.legend()

# Save the diagram to a bytes buffer
buf = io.BytesIO()
plt.savefig(buf, format='png')
buf.seek(0)

# Encode the diagram as base64
diagram = base64.b64encode(buf.getvalue()).decode()

@app.route('/')
def index():
    return render_template('index.html', timestamps_get=timestamps_get, timestamps_post=timestamps_post, count_get=len(timestamps_get), count_post=len(timestamps_post), diagram=diagram)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=4000)
