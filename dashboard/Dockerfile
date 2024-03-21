# Use the official Python base image with version specified
FROM python:latest

# Set the working directory inside the container
WORKDIR /app/dashboard

# Copy the requirements file to the working directory
COPY requirements.txt .

# Install the Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code to the working directory
COPY . .

# Expose the port on which the Flask app will run
EXPOSE 4000

# Set the environment variables (if necessary)
# ENV VARIABLE_NAME value

# Run the Flask app
CMD ["python", "dashboard.py"]
