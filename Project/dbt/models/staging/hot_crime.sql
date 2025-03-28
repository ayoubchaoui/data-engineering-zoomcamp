WITH raw_staging AS (
    SELECT * FROM   {{ source('src','hot_crime')}}
)
SELECT
        _id  as Id,
        EVENT_UNIQUE_ID,                  
        OCCURRENCE_YEAR,                  
        OCCURRENCE_DATE,                
        OCCURRENCE_TIME,                   
        REPORTED_YEAR,                     
        REPORTED_DATE,                    
        REPORTED_TIME,                     
        DIVISION,                         
        LOCATION_TYPE,                    
        AGE_BIAS,                         
        MENTAL_OR_PHYSICAL_DISABILITY,    
        RACE_BIAS,                        
        ETHNICITY_BIAS,                
        LANGUAGE_BIAS,                 
        RELIGION_BIAS,                    
        SEXUAL_ORIENTATION_BIAS,          
        GENDER_BIAS,                      
        MULTIPLE_BIAS,                   
        PRIMARY_OFFENCE,                  
        HOOD_158,                         
        NEIGHBOURHOOD_158,                
        HOOD_140,                         
        NEIGHBOURHOOD_140,                
        ARREST_MADE                      
FROM
    raw_staging
