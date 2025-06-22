CREATE OR REPLACE VIEW prep_wx_milton_h AS
SELECT
    airport_code,
    date,
    MAX(avg_wind_speed_kmh) AS peak_wind_speed_kmh,
    SUM(precipitation_mm) AS total_precip_mm,
    AVG(humidity_perc) AS avg_humidity_perc,
    AVG(temp_c) AS avg_temp_c,
    MIN(pressure_hpa) AS min_pressure_hpa
FROM stag_wx_milton_h
GROUP BY airport_code, date

/*  Aggregates hourly weather data into daily summaries per airport.
    Includes daily totals, averages, and extremes for key weather variables.
    
    -- DO NOT USE for hourly insights (values are rolled up by day) */