-- models/joined_crime_data.sql

WITH hote_crime AS (
    SELECT
        _id,
        EVENT_UNIQUE_ID,
        OCCURRENCE_YEAR,
        OCCURRENCE_DATE,
        REPORTED_YEAR,
        REPORTED_DATE,
        DIVISION,
        LOCATION_TYPE,
        PRIMARY_OFFENCE,
        HOOD_158,
        NEIGHBOURHOOD_158
    FROM {{ ref('hote_crime') }}  -- Referring to the hote_crime table in DBT
),
major_crime AS (
    SELECT
        _id,
        EVENT_UNIQUE_ID,
        REPORT_DATE,
        OCC_DATE,
        REPORT_YEAR,
        REPORT_MONTH,
        REPORT_DAY,
        REPORT_DOY,
        DIVISION AS MAJOR_CRIME_DIVISION,
        LOCATION_TYPE AS MAJOR_CRIME_LOCATION_TYPE,
        OFFENCE,
        HOOD_158 AS MAJOR_HOOD_158,
        NEIGHBOURHOOD_158 AS MAJOR_NEIGHBOURHOOD_158
    FROM {{ ref('major_crime') }}  -- Referring to the major_crime table in DBT
)

SELECT
    h.EVENT_UNIQUE_ID,
    h.OCCURRENCE_YEAR,
    h.OCCURRENCE_DATE,
    h.REPORTED_YEAR,
    h.REPORTED_DATE,
    h.DIVISION AS HOTE_DIVISION,
    h.LOCATION_TYPE AS HOTE_LOCATION_TYPE,
    h.PRIMARY_OFFENCE,
    h.HOOD_158 AS HOTE_HOOD_158,
    h.NEIGHBOURHOOD_158 AS HOTE_NEIGHBOURHOOD_158,
    m.REPORT_DATE,
    m.OCC_DATE,
    m.REPORT_YEAR,
    m.REPORT_MONTH,
    m.REPORT_DAY,
    m.REPORT_DOY,
    m.MAJOR_CRIME_DIVISION,
    m.MAJOR_CRIME_LOCATION_TYPE,
    m.OFFENCE AS MAJOR_CRIME_OFFENCE,
    m.MAJOR_HOOD_158,
    m.MAJOR_NEIGHBOURHOOD_158
FROM
    hote_crime h
JOIN
    major_crime m
ON
    h.EVENT_UNIQUE_ID = m.EVENT_UNIQUE_ID
