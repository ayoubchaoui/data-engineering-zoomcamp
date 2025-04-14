{{ config(materialized='table') }}

WITH meta_data AS (
    SELECT 
        *
    FROM {{ ref('stg_meto_data') }}  -- Referencing the stg_meto_data model
)

SELECT
    id,
    Year,
    Month,
    Day,
    Hour, 
    temperature,
    rain,
    wind_speed,
    humidity
FROM meta_data  
WHERE Hour BETWEEN 7 AND 19  
