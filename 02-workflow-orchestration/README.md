# Workflow Orchestration with Kestra

Welcome to the Workflow Orchestration project! This project is part of the Data Engineering Zoomcamp, where we explore workflow orchestration using **Kestra**, an open-source, event-driven orchestration platform. Kestra simplifies building both scheduled and event-driven workflows using Infrastructure as Code practices.

## Project Overview

In this project, we build ETL (Extract, Transform, Load) pipelines for **Yellow and Green Taxi data** from NYC’s Taxi and Limousine Commission (TLC). The pipelines are designed to:

1. **Extract** data from CSV files.
2. **Load** the data into **Postgres** or **Google Cloud Platform (GCS + BigQuery)**.
3. Explore **scheduling** and **backfilling** workflows.

The project is divided into two main sections:
- **Local Workflows**: Using a local Postgres database.
- **Cloud Workflows**: Using Google Cloud Platform (GCP) with GCS and BigQuery.

---

## Project Structure

The project is organized as follows:

```
.
├── flows/
│   ├── 01_getting_started_data_pipeline.yaml
│   ├── 02_postgres_taxi.yaml
│   ├── 02_postgres_taxi_scheduled.yaml
│   ├── 03_postgres_dbt.yaml
│   ├── 04_gcp_kv.yaml
│   ├── 05_gcp_setup.yaml
│   ├── 06_gcp_taxi.yaml
│   ├── 06_gcp_taxi_scheduled.yaml
│   └── 07_gcp_dbt.yaml
```

---

## Setup

### 1. **Set Up Kestra with Docker Compose**

Kestra is set up using Docker Compose, which includes:
- A container for the **Kestra server**.
- A container for the **Postgres database**.

To start the containers, run:

```bash
cd 02-workflow-orchestration/
docker compose up -d
```

Once the containers are running, access the Kestra UI at [http://localhost:8080](http://localhost:8080).

### 2. **Import Flows Programmatically**

If you prefer to add flows programmatically using Kestra's API, run the following commands:

```bash
curl -X POST http://localhost:8080/api/v1/flows/import -F fileUpload=@flows/01_getting_started_data_pipeline.yaml
curl -X POST http://localhost:8080/api/v1/flows/import -F fileUpload=@flows/02_postgres_taxi.yaml
curl -X POST http://localhost:8080/api/v1/flows/import -F fileUpload=@flows/02_postgres_taxi_scheduled.yaml
curl -X POST http://localhost:8080/api/v1/flows/import -F fileUpload=@flows/03_postgres_dbt.yaml
curl -X POST http://localhost:8080/api/v1/flows/import -F fileUpload=@flows/04_gcp_kv.yaml
curl -X POST http://localhost:8080/api/v1/flows/import -F fileUpload=@flows/05_gcp_setup.yaml
curl -X POST http://localhost:8080/api/v1/flows/import -F fileUpload=@flows/06_gcp_taxi.yaml
curl -X POST http://localhost:8080/api/v1/flows/import -F fileUpload=@flows/06_gcp_taxi_scheduled.yaml
curl -X POST http://localhost:8080/api/v1/flows/import -F fileUpload=@flows/07_gcp_dbt.yaml
```

---

## Workflows

### 1. **Getting Started Pipeline**

This is an introductory flow to demonstrate a simple data pipeline:
- Extracts data via an HTTP REST API.
- Transforms the data using Python.
- Queries the data using DuckDB.

**Flow File**: `01_getting_started_data_pipeline.yaml`

---

### 2. **Local DB: Load Taxi Data to Postgres**

This workflow extracts CSV data partitioned by year and month, creates tables, loads data into a monthly table, and merges the data into the final destination table.

**Flow File**: `02_postgres_taxi.yaml`

---

### 3. **Local DB: Scheduling and Backfills**

This workflow schedules the pipeline to run daily at 9 AM UTC and demonstrates how to backfill historical data.

**Flow File**: `02_postgres_taxi_scheduled.yaml`

---

### 4. **Local DB: Orchestrate dbt Models**

This workflow uses **dbt** to transform raw data ingested into the local Postgres database. It syncs dbt models from Git and runs the `dbt build` command.

**Flow File**: `03_postgres_dbt.yaml`

---

### 5. **GCP Setup**

Before loading data to GCP, we need to set up the Google Cloud Platform. Adjust the `04_gcp_kv.yaml` flow to include your service account, GCP project ID, BigQuery dataset, and GCS bucket name.

**Flow File**: `04_gcp_kv.yaml`

---

### 6. **GCP Workflow: Load Taxi Data to BigQuery**

This workflow loads Yellow and Green Taxi data into **Google Cloud Storage (GCS)** and **BigQuery**.

**Flow File**: `06_gcp_taxi.yaml`

---

### 7. **GCP Workflow: Schedule and Backfill Full Dataset**

This workflow schedules the pipeline to run daily at 9 AM UTC for the Green dataset and 10 AM UTC for the Yellow dataset. It also allows backfilling historical data.

**Flow File**: `06_gcp_taxi_scheduled.yaml`

---

### 8. **GCP Workflow: Orchestrate dbt Models**

This workflow uses **dbt** to transform raw data ingested into BigQuery. It syncs dbt models from Git and runs the `dbt build` command.

**Flow File**: `07_gcp_dbt.yaml`

---

## Bonus: Deploy to the Cloud

Once the ETL pipeline is working locally and in the cloud, you can deploy Kestra to the cloud to orchestrate your workflows automatically. This section covers:
- Installing Kestra on Google Cloud.
- Syncing and deploying workflows from a Git repository.

---

## Additional Resources

- [Kestra Documentation](https://kestra.io/docs/)
- [Kestra Blueprints Library](https://kestra.io/blueprints)
- [Kestra Plugins](https://kestra.io/plugins)
- [Kestra GitHub Repository](https://github.com/kestra-io/kestra)
- [Join Kestra Slack Community](http://kestra.io/slack)

---

## Troubleshooting

If you encounter issues:
1. Ensure you are using the correct Docker images:
   - `kestra/kestra:latest` (stable release).
   - `postgres:latest` (PostgreSQL 15 or higher).
2. If port `8080` is occupied, adjust the Kestra Docker Compose file to use a different port.
3. For Linux users, if you encounter `Connection Refused` errors, modify the Docker Compose file to use `postgres_zoomcamp` instead of `host.docker.internal`.


---

Enjoy building your workflows with Kestra! 🚀
