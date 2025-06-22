CREATE OR REPLACE VIEW stag_flights_milton AS
SELECT
    flight_date::DATE,
    sched_dep_time,
    dep_time,
    dep_delay,
    arr_delay,
    airline,
    flight_number,
    origin,
    dest,
    distance,
    cancelled,
    diverted
FROM flights_oct2024

/*  Extracts flight-level details for each scheduled departure.
    Includes flight times, delays, airline info, and cancellation/diversion flags.  /*