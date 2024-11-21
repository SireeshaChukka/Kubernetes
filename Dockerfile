# Use the official Ubuntu image as the base image
FROM ubuntu:20.04

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements.txt file to the container
COPY requirements.txt /app/

# Copy the rest of the application code (e.g., 'devops' folder) to the container
COPY devops /app/

# Update package list and install dependencies including Python, pip, and virtualenv
RUN apt-get update && \
    apt-get install -y python3 python3-pip python3-venv && \
    # Create a Python virtual environment
    python3 -m venv /opt/venv && \
    # Install dependencies from requirements.txt in the virtual environment
    /opt/venv/bin/pip install --upgrade pip && \
    /opt/venv/bin/pip install -r requirements.txt

# Set the environment variable to use the virtual environment
ENV PATH="/opt/venv/bin:$PATH"

# Set the default directory where the application will run
WORKDIR /app

# Expose port 8000 to make the Django app accessible
EXPOSE 8000

# Define the entry point for the container
ENTRYPOINT ["python3"]

# Set the default command to run Django's development server
CMD ["manage.py", "runserver", "0.0.0.0:8000"]




