FROM python:3.7-slim

WORKDIR /app

# Install system dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

COPY requirements/ /app/requirements/
COPY requirements.txt /app/

RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/

# Use the port assigned by Cloud Run
ENV PORT 8080

CMD python init_db.py && exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 autoapp:app
