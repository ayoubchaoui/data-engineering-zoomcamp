WITH raw_data AS (
    SELECT
        *
    FROM {{ source('staging', 'stg_meto_data') }}
)

SELECT
    -- identifiers
    {{ dbt_utils.generate_surrogate_key(['time', 'temperature_2m']) }} AS id,

    -- timestamps
    CAST(time AS timestamp) AS time,
    EXTRACT(YEAR FROM CAST(time AS TIMESTAMP)) AS Year, 
    EXTRACT(MONTH FROM CAST(time AS TIMESTAMP)) AS Month,
    EXTRACT(DAY FROM CAST(time AS TIMESTAMP)) AS Day,
    EXTRACT(HOUR FROM CAST(time AS TIMESTAMP)) AS Hour,

    -- weather data
    relative_humidity_2m as Humidity, 
    CAST(temperature_2m AS numeric) AS temperature,
    CAST(rain AS numeric) AS rain,
    CAST(wind_speed_10m AS numeric) AS wind_speed
FROM raw_data
