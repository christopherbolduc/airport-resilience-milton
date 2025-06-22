CREATE OR REPLACE VIEW mart_airport_daily_milton AS
SELECT
    f.airport_code,
    f.flight_date AS date,
    f.num_flights,
    f.num_cancelled,
    f.pct_cancelled,
    f.avg_dep_delay,
    w.peak_wind_speed_kmh,
    w.total_precip_mm,
    w.min_pressure_hpa,
    w.avg_temp_c
FROM prep_flights_milton f
LEFT JOIN prep_wx_milton_h w
    ON f.airport_code = w.airport_code AND f.flight_date = w.date
WHERE f.airport_code IN ('SRQ', 'TPA', 'MCO', 'PIE', 'DAB')

/*  Combines daily flight and weather summaries for selected Florida airports.
    Useful for analyzing how weather conditions relate to flight activity and delays.   */