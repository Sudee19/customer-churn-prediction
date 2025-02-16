FROM apache/airflow:2.7.0

USER root
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    build-essential \
    python3-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

USER airflow

# Install Python packages
RUN pip install --no-cache-dir \
    pandas==1.5.0 \
    openpyxl==3.0.10 \
    scikit-learn==1.0.2 \
    python-dotenv==1.0.0

# Create necessary directories
RUN mkdir -p /opt/airflow/data/tmp /opt/airflow/data/processed

WORKDIR /opt/airflow
