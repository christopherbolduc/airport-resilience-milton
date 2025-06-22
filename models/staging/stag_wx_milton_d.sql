CREATE OR REPLACE VIEW stag_wx_milton_d AS
WITH daily_raw AS (
    SELECT
        airport_code,
        station_id,
        JSON_ARRAY_ELEMENTS(extracted_data -> 'data') AS json_data
    FROM wx_milton_d_raw
),
daily_data AS (
    SELECT  
        airport_code,
        station_id,
        (json_data ->> 'date')::DATE AS date,
        (json_data ->> 'tavg')::NUMERIC AS avg_temp_c,
        (json_data ->> 'wspd')::NUMERIC AS avg_wind_speed_kmh,
        (json_data ->> 'prcp')::NUMERIC AS precipitation_mm,
        (json_data ->> 'pres')::NUMERIC AS avg_pressure_hpa
    FROM daily_raw
)
SELECT * 
FROM daily_data

/*  Parses and flattens daily weather data from JSON format.
    Captures key daily metrics like average temperature, wind, precipitation, and pressure. */