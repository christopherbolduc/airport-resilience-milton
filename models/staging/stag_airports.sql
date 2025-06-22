CREATE OR REPLACE VIEW stag_airports AS
SELECT
    faa AS airport_code,
    name AS airport_name,
    lat,
    lon,
    city,
    country
FROM airports

/*  Loads and renames basic airport information for easier use in other views.
    Includes airport code, name, location, and country details. */
    
    -- DO NOT USE for precise geographic calculations (lat/lon may need conversion)