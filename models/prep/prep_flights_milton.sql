CREATE OR REPLACE VIEW prep_flights_milton AS
SELECT
    origin AS airport_code,
    flight_date,
    COUNT(*) AS num_flights,
    SUM(CASE WHEN cancelled = 1 THEN 1 ELSE 0 END) AS num_cancelled,
    ROUND(
        SUM(CASE WHEN cancelled = 1 THEN 1 ELSE 0 END)::NUMERIC / COUNT(*), 
        3
    ) AS pct_cancelled,
    ROUND(
        AVG(CASE 
            WHEN cancelled = 0 AND dep_delay IS NOT NULL THEN dep_delay 
            END), 
        2
    ) AS avg_dep_delay
FROM stag_flights_milton
GROUP BY origin, flight_date

/*  Summarizes daily flight activity by airport.
    Calculates number of flights, cancellations, cancellation rate, and average departure delay.    */