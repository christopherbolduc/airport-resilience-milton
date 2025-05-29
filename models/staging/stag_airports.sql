CREATE OR REPLACE VIEW stag_airports AS
SELECT
    faa AS airport_code,
    name AS airport_name,
    lat,
    lon,
    city,
    country
FROM airports