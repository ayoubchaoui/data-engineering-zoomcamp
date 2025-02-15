{{
    config(
        materialized='view'
    )
}}

with source  as 
(
  select * from {{ source('staging','green_tripdata') }}
 
)
renamed as {
    select
    VendorID,
    lpep_pickup_datetime,
    lpep_dropoff_datetime,
     store_and_fwd_flag,
     RatecodeID
}
