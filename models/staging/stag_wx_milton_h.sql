CREATE OR REPLACE VIEW stag_wx_milton_h AS
WITH hourly_raw AS (
    SELECT
        airport_code,
        station_id,
        JSON_ARRAY_ELEMENTS(extracted_data -> 'data') AS json_data
    FROM wx_milton_h_raw
),
hourly_data AS (
    SELECT  
        airport_code,
        station_id,
        (json_data ->> 'time')::TIMESTAMP AS timestamp,
        ((json_data ->> 'time')::TIMESTAMP)::DATE AS date,
        ((json_data ->> 'time')::TIMESTAMP)::TIME AS time,
        (json_data ->> 'temp')::NUMERIC AS temp_c,
        (json_data ->> 'rhum')::NUMERIC AS humidity_perc,
        (json_data ->> 'prcp')::NUMERIC AS precipitation_mm,
        ((json_data->> 'wdir')::NUMERIC)::INTEGER AS wind_direction,
        (json_data ->> 'wspd')::NUMERIC AS avg_wind_speed_kmh,
        (json_data ->> 'pres')::NUMERIC AS pressure_hpa,
        (json_data ->> 'coco')::INTEGER AS condition_code
    FROM hourly_raw
)
SELECT * 
FROM hourly_data