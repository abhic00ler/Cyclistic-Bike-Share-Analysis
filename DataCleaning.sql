- Data Cleaning in SQL

-Combine all tables into one table and remove all nulls - 

Select *
From ((select
  *
From 
  `capstone-case-study-389823.cyclistic_2022_tripdata.202201_tripdata`)

union all
 
(select
  *
From 
  `capstone-case-study-389823.cyclistic_2022_tripdata.202202_tripdata`)

UNION ALL

(select
  *
From 
  `capstone-case-study-389823.cyclistic_2022_tripdata.202203_tripdata`)
UNION ALL

(select
  *
From 
  `capstone-case-study-389823.cyclistic_2022_tripdata.202204_tripdata`)

UNION ALL

(select
  *
From 
  `capstone-case-study-389823.cyclistic_2022_tripdata.202205_tripdata`)
UNION ALL

(select
  *
From 
  `capstone-case-study-389823.cyclistic_2022_tripdata.202206_tripdata`)
UNION ALL

(select
  *
From 
  `capstone-case-study-389823.cyclistic_2022_tripdata.202207_tripdata`)
UNION ALL

(select
  *
From 
  `capstone-case-study-389823.cyclistic_2022_tripdata.202208_tripdata`)
UNION ALL

(select
  *
From 
  `capstone-case-study-389823.cyclistic_2022_tripdata.202209_tripdata`)
UNION ALL

(select
  *
From 
  `capstone-case-study-389823.cyclistic_2022_tripdata.202210_tripdata`)
UNION ALL

(select
  *
From 
  `capstone-case-study-389823.cyclistic_2022_tripdata.202211_tripdata`)
UNION ALL

(select
  *
From 
  `capstone-case-study-389823.cyclistic_2022_tripdata.202212_tripdata`))

WHERE 
  start_station_name is not null
  and end_station_name is not null
  and end_station_id is not null
  and start_station_id is not null
  and end_lat is not null  
  and end_lng is not null
  
  **Data saved into new table called combine_data**
  
  
  
  
  -- days of week by SQL , tho I have already done it using excel
  
  
  CREATE TABLE IF NOT EXISTS `2022_tripdata.alldata_cleaned` AS (
  SELECT 
    a.ride_id, rideable_type, started_at, ended_at, 
    ride_length,
    CASE EXTRACT(DAYOFWEEK FROM started_at) 
      WHEN 1 THEN 'Sun'
      WHEN 2 THEN 'Mon'
      WHEN 3 THEN 'Tue'
      WHEN 4 THEN 'Wed'
      WHEN 5 THEN 'Thu'
      WHEN 6 THEN 'Fri'
      WHEN 7 THEN 'Sat'    
    END AS day_of_week,
    CASE EXTRACT(MONTH FROM started_at)
      WHEN 1 THEN 'Jan'
      WHEN 2 THEN 'Feb'
      WHEN 3 THEN 'Mar'
      WHEN 4 THEN 'Apr'
      WHEN 5 THEN 'May'
      WHEN 6 THEN 'Jun'
      WHEN 7 THEN 'Jul'
      WHEN 8 THEN 'Aug'
      WHEN 9 THEN 'Sep'
      WHEN 10 THEN 'Oct'
      WHEN 11 THEN 'Nov'
      WHEN 12 THEN 'Dec'
    END AS month,
    start_station_name, end_station_name, 
    start_lat, start_lng, end_lat, end_lng, member_casual
  FROM `2022_tripdata.all_tripdata` a
  JOIN (
    SELECT ride_id, (
      EXTRACT(HOUR FROM (ended_at - started_at)) * 60 +
      EXTRACT(MINUTE FROM (ended_at - started_at)) +
      EXTRACT(SECOND FROM (ended_at - started_at)) / 60) AS ride_length
    FROM `2022_tripdata.all_tripdata`
  ) b 
  ON a.ride_id = b.ride_id
  WHERE 
    start_station_name IS NOT NULL AND
    end_station_name IS NOT NULL AND
    end_lat IS NOT NULL AND
    end_lng IS NOT NULL AND
    ride_length > 1 AND ride_length < 1440
);
