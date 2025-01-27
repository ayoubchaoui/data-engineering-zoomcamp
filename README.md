# Data Engineering Zoomcamp Project 🚀  

This repository contains my implementation of the **Data Engineering Zoomcamp** project. It includes exercises and projects related to **Docker**, **Postgres**, and **Terraform**, leveraging modern data engineering tools and cloud technologies.  

## Table of Contents  
- [Introduction](#introduction)  
- [Technologies](#technologies)  
- [Features](#features)  
- [Project Structure](#project-structure)  
- [How to Run Locally](#how-to-run-locally)  
- [References](#references)  

---

## Introduction  
This project is part of the [Data Engineering Zoomcamp](https://github.com/DataTalksClub/data-engineering-zoomcamp), a hands-on learning experience designed to build strong foundational skills in data engineering.  

The main topics covered include:  
1. Dockerizing an ingestion pipeline.  
2. Managing infrastructure with **Terraform** on **Google Cloud Platform (GCP)**.  
3. Running PostgreSQL, pgAdmin, and Docker Compose.  

---

## Technologies  
The following technologies are used in this project:  
- **Docker**: Containerization of applications and pipelines.  
- **PostgreSQL**: Database for ingesting and managing datasets.  
- **pgAdmin**: PostgreSQL management tool.  
- **Terraform**: Infrastructure as Code (IaC) for provisioning resources in GCP.  
- **Google Cloud Platform (GCP)**: Cloud environment to host data pipelines.  

---

## Features  
1. Ingested NYC taxi data into PostgreSQL using Docker.  
2. Automated infrastructure provisioning on GCP with Terraform.  
3. Hands-on practice with Docker Compose and containerized pipelines.  

---



## Project Structure  

  ``` plaintext  
📦 data-engineering-zoomcamp-project  
├── 📂 1_terraform_gcp         # Terraform setup for GCP  
├── 📂 2_docker_sql            # Docker and Postgres setup  
├── 📂 data                    # Sample data files  
├── 📜 docker-compose.yml      # Docker Compose configuration  
├── 📜 ingestion_script.py     # Python script for data ingestion  
├── 📜 main.tf                 # Terraform main file  
├── 📜 variables.tf            # Terraform variables  
├── 📜 README.md               # Project documentation (this file)

```

## How to Run Locally  
To run this project on your machine:

## Prerequisites
1. Install Docker and Docker Compose.
2. Install Terraform.
3. Have a valid Google Cloud Platform (GCP) account.

Steps
Clone this repository:
```bash
git clone https://github.com/<your-username>/data-engineering-zoomcamp.git  
cd data-engineering-zoomcamp  

```
2.Build and run Docker containers:
```bash
docker-compose up   
```

3.Deploy GCP infrastructure using Terraform:
```bash
terraform init  
terraform apply
```
4.Run the data ingestion script:
```bash
docker-compose up
python ingestion_script.py  
```
## References
1.Data Engineering Zoomcamp - Official GitHub
2.Course Introduction Slides
3.YouTube Video Playlist


