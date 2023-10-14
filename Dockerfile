# Use the official Python image from Docker Hub
FROM python:3.8-slim-buster

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the requirements file into the container
COPY requirements.txt .

# Install the Python packages
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entire current directory into the container
COPY . .

# Expose the port the app will run on
EXPOSE 5000

# Run the application
CMD ["python", "app.py"]
