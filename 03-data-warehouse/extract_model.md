## Model deployment
[Tutorial](https://cloud.google.com/bigquery-ml/docs/export-model-tutorial)
### Steps

# Authenticate with Google Cloud
gcloud auth login 

# Export BigQuery ML Model to Google Cloud Storage (GCS)
bq --project_id=kestra-449718 extract -m zoomcampi.tip_model gs://taxi_ml_model/tip_model

# Create a temporary local directory for the model
mkdir /tmp/model

# Copy the exported model from GCS to local storage
gsutil cp -r gs://taxi_ml_model/tip_model /tmp/model

# Create the directory structure required for TensorFlow Serving
mkdir -p serving_dir/tip_model/1

# Move model files to the TensorFlow Serving directory
cp -r /tmp/model/tip_model/* serving_dir/tip_model/1

# Pull the TensorFlow Serving Docker image
docker pull tensorflow/serving

# Run the TensorFlow model server inside a Docker container
docker run -p 8501:8501 --mount type=bind,source=`pwd`/serving_dir/tip_model,target=/models/tip_model \
  -e MODEL_NAME=tip_model -t tensorflow/serving &

# Send a test prediction request
curl -d '{"instances": [{"passenger_count":1, "trip_distance":12.2, "PULocationID":"193", "DOLocationID":"264", "payment_type":"2","fare_amount":20.4,"tolls_amount":0.0}]}' \
  -X POST http://localhost:8501/v1/models/tip_model:predict

# API endpoint for TensorFlow Serving
http://localhost:8501/v1/models/tip_model
