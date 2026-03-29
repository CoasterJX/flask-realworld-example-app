# Using python 3.7-slim as base image
FROM python:3.7-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV FLASK_APP autoapp.py

# Set work directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
COPY requirements/ ./requirements/
RUN pip install --no-cache-dir -r requirements.txt

# Copy project
COPY . .

# Expose port 8080
EXPOSE 8080

# Run database initialization and then gunicorn
CMD ["sh", "-c", "python init_db.py && gunicorn --bind 0.0.0.0:8080 autoapp:app"]
