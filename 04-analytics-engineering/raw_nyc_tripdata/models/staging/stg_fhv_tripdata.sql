{{ config(
    materialized='view'
) }}

WITH tripdata AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY dispatching_base_num, pickup_datetime) AS rn
    FROM {{ source('staging', 'fhv_tripdata') }}
    WHERE dispatching_base_num IS NOT NULL
)

SELECT
    -- Identifiers
    {{ dbt_utils.generate_surrogate_key(['dispatching_base_num', 'pickup_datetime']) }} AS tripid,
    
    -- Base info
    {{ dbt.safe_cast("dispatching_base_num", api.Column.translate_type("string")) }} AS dispatching_base_num,

    -- Timestamps
    CAST(pickup_datetime AS TIMESTAMP) AS pickup_datetime,
    CAST(dropOff_datetime AS TIMESTAMP) AS dropoff_datetime,

    -- Location IDs
    {{ dbt.safe_cast("PUlocationID", api.Column.translate_type("integer")) }} AS pickup_locationid

FROM tripdata
WHERE rn = 1

{% if var('is_test_run', default=true) %}
LIMIT 100
{% endif %}
