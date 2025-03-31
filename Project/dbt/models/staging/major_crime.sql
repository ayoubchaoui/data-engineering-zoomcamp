WITH raw_staging AS (
    SELECT * FROM   {{ source('staging','major_crime')}}
)
SELECT
        _id         as id,            
        EVENT_UNIQUE_ID,       
        REPORT_DATE,           
        OCC_DATE,              
        REPORT_YEAR,            
        REPORT_MONTH,          
        REPORT_DAY,            
        REPORT_DOY,            
        REPORT_DOW,            
        REPORT_HOUR,            
        OCC_YEAR,             
        OCC_MONTH,             
        OCC_DAY,             
        OCC_DOY,             
        OCC_DOW,               
        OCC_HOUR,               
        DIVISION,              
        LOCATION_TYPE,        
        PREMISES_TYPE,         
        UCR_CODE,               
        UCR_EXT,                
        OFFENCE,               
        MCI_CATEGORY,          
        HOOD_158,              
        NEIGHBOURHOOD_158,     
        HOOD_140,              
        NEIGHBOURHOOD_140,     
        LONG_WGS84,           
        LAT_WGS84 
FROM
    raw_staging           
