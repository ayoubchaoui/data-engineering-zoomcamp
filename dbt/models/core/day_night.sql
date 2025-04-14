{{{ config(materialized='table') }}

with meta_data as (
    select 
        *
    from {{ ref('stg_meto_data') }}

)

select
    -- identifiers
    id,
    Year,
    Month,
    Day,
    Hour,
    temperature,
    rain,
    wind_speed,
    hour,
    humidity 
    
from meta_data  where Hour >19 or Hour <7  