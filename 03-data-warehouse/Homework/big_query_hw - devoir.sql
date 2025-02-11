

-- Creating an external table referring to the GCS path
CREATE OR REPLACE EXTERNAL TABLE `kestra-449718.zoomcamp.external_yellow_tripdata`
OPTIONS (
  format = 'PARQUET',
  uris = ['gs://kestra-zoomcamp-bucket-01/yellow_tripdata_2024-*.parquet']
);

SELECT count(*) FROM `taxi-rides-ny.nytaxi.fhv_tripdata`;


SELECT COUNT(DISTINCT(dispatching_base_num)) FROM `taxi-rides-ny.nytaxi.fhv_tripdata`;


CREATE OR REPLACE TABLE `taxi-rides-ny.nytaxi.fhv_nonpartitioned_tripdata`
AS SELECT * FROM `taxi-rides-ny.nytaxi.fhv_tripdata`;

CREATE OR REPLACE TABLE `taxi-rides-ny.nytaxi.fhv_partitioned_tripdata`
PARTITION BY DATE(dropoff_datetime)
CLUSTER BY dispatching_base_num AS (
  SELECT * FROM `taxi-rides-ny.nytaxi.fhv_tripdata`
);

SELECT count(*) FROM  `taxi-rides-ny.nytaxi.fhv_nonpartitioned_tripdata`
WHERE DATE(dropoff_datetime) BETWEEN '2024-01-01' AND '2024-03-31'
  AND dispatching_base_num IN ('B00987', 'B02279', 'B02060');


SELECT count(*) FROM `taxi-rides-ny.nytaxi.fhv_partitioned_tripdata`
WHERE DATE(dropoff_datetime) BETWEEN '2024-01-01' AND '2024-03-31'
  AND dispatching_base_num IN ('B00987', 'B02279', 'B02060');
