/*CSV

*/

CREATE TABLE us_counties_pop_est_2019 (
    state_fips text,                         -- State FIPS code
    county_fips text,                        -- County FIPS code
    region smallint,                         -- Region
    state_name text,                         -- State name	
    county_name text,                        -- County name
    area_land bigint,                        -- Area (Land) in square meters
    area_water bigint,                       -- Area (Water) in square meters
    internal_point_lat numeric(10,7),        -- Internal point (latitude)
    internal_point_lon numeric(10,7),        -- Internal point (longitude)
    pop_est_2018 integer,                    -- 2018-07-01 resident total population estimate
    pop_est_2019 integer,                    -- 2019-07-01 resident total population estimate
    births_2019 integer,                     -- Births from 2018-07-01 to 2019-06-30
    deaths_2019 integer,                     -- Deaths from 2018-07-01 to 2019-06-30
    international_migr_2019 integer,         -- Net international migration from 2018-07-01 to 2019-06-30
    domestic_migr_2019 integer,              -- Net domestic migration from 2018-07-01 to 2019-06-30
    residual_2019 integer,                   -- Residual for 2018-07-01 to 2019-06-30
    CONSTRAINT counties_2019_key PRIMARY KEY (state_fips, county_fips)	
);
SELECT * FROM us_counties_pop_est_2019;

/*import from CSV*/
COPY us_counties_pop_est_2019
FROM '/home/adrian/gits/postgreSQL/cap5/us_counties_pop_est_2019.csv'
WITH (FORMAT CSV, HEADER);

SELECT county_name, state_name, internal_point_lat, internal_point_lon
FROM us_counties_pop_est_2019
ORDER BY internal_point_lon DESC
LIMIT 5;

/*importovanie z viacero zdrojov*/

CREATE TABLE supervisor_salaries (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    town text,
    county text,
    supervisor text,
    start_date text,
    salary numeric(10,2),
    benefits numeric(10,2)
);

-- Importing salaries data from CSV to three table columns

COPY supervisor_salaries (town, supervisor, salary)
FROM '/home/adrian/gits/postgreSQL/cap5/supervisor_salaries.csv'
WITH (FORMAT CSV, HEADER);


SELECT * FROM supervisor_salaries ORDER BY id LIMIT 2;

/*Importing subset of Rows with COPY

delete data from table
*/
DELETE FROM supervisor_salaries;

COPY supervisor_salaries (town, supervisor, salary)
FROM '/home/adrian/gits/postgreSQL/cap5/supervisor_salaries.csv'
WITH (FORMAT CSV, HEADER)
WHERE town = 'New Brillig';

SELECT * FROM supervisor_salaries;

/*Adding a value to a column during import
	-- TEMPORARY TABLE dobra sucast pipeliny, asi ako filter
*/

CREATE TEMPORARY TABLE supervisor_salaries_temp
	(LIKE supervisor_salaries INCLUDING ALL);
-- do temp
COPY supervisor_salaries_temp (town, supervisor, salary)
FROM '/home/adrian/gits/postgreSQL/cap5/supervisor_salaries.csv'
WITH (FORMAT CSV, HEADER);

INSERT INTO supervisor_salaries (town, county, supervisor, salary)
SELECT town, 'Mills', supervisor, salary  --takto vlozim hodnotu do county
FROM supervisor_salaries_temp;

DROP TABLE supervisor_salaries_temp;

SELECT * FROM supervisor_salaries;

/*Using COPY to Export Data*/

-- vsetky data aj s Header
COPY us_counties_pop_est_2019
TO '/tmp/us_counties_export.txt'
WITH (FORMAT CSV, HEADER, DELIMITER ',', QUOTE '"');  --ked som nespecifikoval QUOTE tak to exportovalo do jedneho stlpca

-- iba particular columns
COPY us_counties_pop_est_2019
	(county_name, internal_point_lat, internal_point_lon)	
TO '/tmp/us_counties_export.txt'
WITH (FORMAT CSV, HEADER, DELIMITER ',', QUOTE '"');

-- eqport query results
COPY (
    SELECT county_name, state_name
    FROM us_counties_pop_est_2019
    WHERE county_name ILIKE '%mill%'
)
TO '/tmp/us_counties_export.txt'
WITH (FORMAT CSV, HEADER, QUOTE '"'); --comma-separated je default 

/*Import v pgAdmin
Tools
Import/Export data
*/

-- na konci
COPY
	(id, movie, actor)
FROM '/tmp/blab.csv'
WITH (FORMAT CSV, HEADER, DELIMITER ':')

COPY (
	SELECT state_name, births_2019 	
	FROM us_counties_pop_est_2019
	ORDER BY births_2019 DESC
	LIMIT 20
)
TO '/tmp/us_top20births.csv'
WITH (FORMAT CSV, HEADER, QUOTE '"');

