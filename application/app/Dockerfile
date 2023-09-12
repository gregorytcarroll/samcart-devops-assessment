# Use an official Python runtime as the base image
FROM python:3.8

# Set the working directory in the container
WORKDIR /app

# Copy your Python application code into the container
COPY . .

# Install any necessary dependencies (e.g., using pip)
RUN pip freeze > requirements.txt

# Define the command to run your Python application
CMD [ "python", "app.py" ]

# deploy.yml will handle the workflow for building and deploying the application