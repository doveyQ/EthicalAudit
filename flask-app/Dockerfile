# Use the official Python base image
FROM python:3.9-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file to the container
COPY requirements.txt .

# Install the dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the Flask application code to the container
COPY . /app

# Set the FLASK_APP environment variable
ENV FLASK_APP=backend.api

# Expose the Flask application port (optional, as it will be accessed through the frontend)
EXPOSE 5000

# Run the Flask application
CMD ["flask", "run", "--host=0.0.0.0"]

