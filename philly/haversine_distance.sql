--from: https://gist.github.com/simonuid/646c6e7a5531025095e8d3b91e445d61#file-great_circle_distance-sql-L4
-- returns distance in meters between a pair of lat/lon points
-- parameters are lat1, lon1, lat2, lon2
-- distance is in meters, based on Earth's radius as 6,373,000 meters.
 CREATE OR REPLACE FUNCTION f_great_circle_distance (Float, Float, Float, Float)
   RETURNS FLOAT
 IMMUTABLE
 AS $$
   SELECT
 	  2 * 6373000 * ASIN( SQRT( ( SIN( RADIANS(($3 - $1) / 2) ) ) ^ 2 + COS(RADIANS($1)) * COS(RADIANS($3)) * (SIN(RADIANS(($4 - $2) / 2))) ^ 2))
 $$ LANGUAGE sql
