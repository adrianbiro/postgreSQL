CREATE EXTENSION postgis;

SELECT postgis_full_version();


SELECT srtext
FROM spatial_ref_sys
WHERE srid = 4326;



--  Using ST_GeomFromText() to create spatial objects

SELECT ST_GeomFromText('POINT(-74.9233606 42.699992)', 4326);

SELECT ST_GeomFromText('LINESTRING(-74.9 42.7, -75.1 42.7)', 4326);

SELECT ST_GeomFromText('POLYGON((-74.9 42.7, -75.1 42.7,
                                 -75.1 42.6, -74.9 42.7))', 4326);

SELECT ST_GeomFromText('MULTIPOINT (-74.9 42.7, -75.1 42.7)', 4326);

SELECT ST_GeomFromText('MULTILINESTRING((-76.27 43.1, -76.06 43.08),
                                        (-76.2 43.3, -76.2 43.4,
                                         -76.4 43.1))', 4326);

SELECT ST_GeomFromText('MULTIPOLYGON((
                                     (-74.92 42.7, -75.06 42.71,
                                      -75.07 42.64, -74.92 42.7),
                                     (-75.0 42.66, -75.0 42.64,
                                      -74.98 42.64, -74.98 42.66,
                                      -75.0 42.66)))', 4326);

-- Using ST_GeogFromText() to create spatial objects

SELECT
ST_GeogFromText('SRID=4326;MULTIPOINT(-74.9 42.7, -75.1 42.7, -74.924 42.6)');

-- Functions specific to making points

SELECT ST_PointFromText('POINT(-74.9233606 42.699992)', 4326);

SELECT ST_MakePoint(-74.9233606, 42.699992);
SELECT ST_SetSRID(ST_MakePoint(-74.9233606, 42.699992), 4326);

-- Functions specific to making LineStrings

SELECT ST_LineFromText('LINESTRING(-105.90 35.67,-105.91 35.67)', 4326);
SELECT ST_MakeLine(ST_MakePoint(-74.9, 42.7), ST_MakePoint(-74.1, 42.4));

-- Functions specific to making Polygons

SELECT ST_PolygonFromText('POLYGON((-74.9 42.7, -75.1 42.7,
                                    -75.1 42.6, -74.9 42.7))', 4326);

SELECT ST_MakePolygon(
           ST_GeomFromText('LINESTRING(-74.92 42.7, -75.06 42.71,
                                       -75.07 42.64, -74.92 42.7)', 4326));

SELECT ST_MPolyFromText('MULTIPOLYGON((
                                       (-74.92 42.7, -75.06 42.71,
                                        -75.07 42.64, -74.92 42.7),
                                       (-75.0 42.66, -75.0 42.64,
                                        -74.98 42.64, -74.98 42.66,
                                        -75.0 42.66)
                                      ))', 4326);


-- ANALYZING FARMERS MARKETS DATA
-- https://www.ams.usda.gov/local-food-directories/farmersmarkets
-- Creating and loading the farmers_markets table

CREATE TABLE farmers_markets (
    fmid bigint PRIMARY KEY,
    market_name text NOT NULL,
    street text,
    city text,
    county text,
    st text NOT NULL,
    zip text,
    longitude numeric(10,7),
    latitude numeric(10,7),
    organic text NOT NULL
);

COPY farmers_markets
FROM '/home/adrian/gits/practical-sql-2/Chapter_15/farmers_markets.csv'
WITH (FORMAT CSV, HEADER);

SELECT count(*) FROM farmers_markets; -- should return 8,681 rows

-- Creating and indexing a geography column
-- There's also a function: https://postgis.net/docs/AddGeometryColumn.html

-- Add column
ALTER TABLE farmers_markets ADD COLUMN geog_point geography(POINT,4326);

-- Now fill that column with the lat/long
UPDATE farmers_markets
SET geog_point = 
     ST_SetSRID(
               ST_MakePoint(longitude,latitude)::geography,4326
               );

-- Add a spatial (R-Tree) index using GIST
CREATE INDEX market_pts_idx ON farmers_markets USING GIST (geog_point);

-- View the geography column
SELECT longitude,
       latitude,
       geog_point,
       ST_AsEWKT(geog_point)
FROM farmers_markets
WHERE longitude IS NOT NULL
LIMIT 5;

-- Listing 15-10: Using ST_DWithin() to locate farmers' markets within 10 kilometers of a point

SELECT market_name,
       city,
       st,
       geog_point
FROM farmers_markets
WHERE ST_DWithin(geog_point,
                 ST_GeogFromText('POINT(-93.6204386 41.5853202)'),
                 10000)
ORDER BY market_name;

--  Using ST_Distance() to calculate the miles between Yankee Stadium
-- and Citi Field (Mets)
-- 1609.344 meters/mile

SELECT ST_Distance(
                   ST_GeogFromText('POINT(-73.9283685 40.8296466)'),
                   ST_GeogFromText('POINT(-73.8480153 40.7570917)')
                   ) / 1609.344 AS mets_to_yanks;


-- Using ST_Distance() for each row in farmers_markets

SELECT market_name,
       city,
       round(
           (ST_Distance(geog_point,
                        ST_GeogFromText('POINT(-93.6204386 41.5853202)')
                        ) / 1609.344)::numeric, 2
            ) AS miles_from_dt
FROM farmers_markets
WHERE ST_DWithin(geog_point,
                 ST_GeogFromText('POINT(-93.6204386 41.5853202)'),
                 10000)
ORDER BY miles_from_dt ASC;

-- Using the <-> distance operator for a nearest neighbors search

SELECT market_name,
       city,
       st,
       round(
           (ST_Distance(geog_point,
                        ST_GeogFromText('POINT(-68.2041607 44.3876414)')
                        ) / 1609.344)::numeric, 2
            ) AS miles_from_bh
FROM farmers_markets
ORDER BY geog_point <-> ST_GeogFromText('POINT(-68.2041607 44.3876414)')
LIMIT 3;


