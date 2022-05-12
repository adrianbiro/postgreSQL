/*Dates and Time
 TIMESTAMP WITH TIME ZONE
 	-- postgres verzia TIMESTAMPTZ
DATE YYYY-MM-DD  -- ISO 9601 
TIME HH:MM:SS
	TIME WITH TIME ZONE
			-- postgres TIMETZ
INTERVAL 12 days 8 hours

*/

-- date_part(text, value)
SELECT
    date_part('year', '2022-12-01 18:37:12 EST'::timestamptz) AS year,
    date_part('month', '2022-12-01 18:37:12 EST'::timestamptz) AS month,
    date_part('day', '2022-12-01 18:37:12 EST'::timestamptz) AS day,
    date_part('hour', '2022-12-01 18:37:12 EST'::timestamptz) AS hour,
    date_part('minute', '2022-12-01 18:37:12 EST'::timestamptz) AS minute,
    date_part('seconds', '2022-12-01 18:37:12 EST'::timestamptz) AS seconds,
    date_part('timezone_hour', '2022-12-01 18:37:12 EST'::timestamptz) AS tz,
    date_part('week', '2022-12-01 18:37:12 EST'::timestamptz) AS week,
    date_part('quarter', '2022-12-01 18:37:12 EST'::timestamptz) AS quarter,
    date_part('epoch', '2022-12-01 18:37:12 EST'::timestamptz) AS epoch;

-- extract(text from value)
SELECT extract(year from '2022-12-01 18:37:12 EST'::timestamptz) AS year;

-- make_date(y, m, d)
-- make_time(h, m, s)
-- make_timestamptz(y, m, d, h, m, s, time zone)

-- make a date
SELECT make_date(2022, 2, 22);
-- make a time
SELECT make_time(18, 4, 30.3);
-- make a timestamp with time zone
SELECT make_timestamptz(2022, 2, 22, 18, 4, 30.3, 'Europe/Lisbon');


-- Retrieving the current date and time

SELECT
    current_timestamp,
    localtimestamp,
    current_date,
    current_time,
    localtime,
    now();

CREATE TABLE current_time_example (
    time_id integer GENERATED ALWAYS AS IDENTITY,
    current_timestamp_col timestamptz,
    clock_timestamp_col timestamptz
);

INSERT INTO current_time_example
            (current_timestamp_col, clock_timestamp_col)
    (SELECT current_timestamp,
            clock_timestamp()
     FROM generate_series(1,1000));

SELECT * FROM current_time_example;

/*Time zones*/

-- Viewing your current time zone setting
SHOW timezone; -- Note: You can see all run-time defaults with SHOW ALL;
--SHOW ALL;
SELECT current_setting('timezone');

-- Using current_setting() inside another function:
SELECT make_timestamptz(2022, 2, 22, 18, 4, 30.3, current_setting('timezone'));

-- Showing time zone abbreviations and names
SELECT * FROM pg_timezone_abbrevs ORDER BY abbrev;
SELECT * FROM pg_timezone_names ORDER BY name;

-- Setting Time Zone

SET TIME ZONE 'US/Pacific';

CREATE TABLE time_zone_test (
    test_date timestamptz
);
INSERT INTO time_zone_test VALUES ('2023-01-01 4:00');

SELECT test_date
FROM time_zone_test;

SET TIME ZONE 'US/Eastern';

SELECT test_date
FROM time_zone_test;

SELECT test_date AT TIME ZONE 'Asia/Seoul'
FROM time_zone_test;

-- Math with dates
SELECT '1929-09-30'::date - '1929-09-27'::date;
SELECT '1929-09-30'::date + '5 years'::interval;


-- Taxi Rides
-- Creating a table and importing NYC yellow taxi data
CREATE TABLE nyc_yellow_taxi_trips (
    trip_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    vendor_id text NOT NULL,
    tpep_pickup_datetime timestamptz NOT NULL,
    tpep_dropoff_datetime timestamptz NOT NULL,
    passenger_count integer NOT NULL,
    trip_distance numeric(8,2) NOT NULL,
    pickup_longitude numeric(18,15) NOT NULL,
    pickup_latitude numeric(18,15) NOT NULL,
    rate_code_id text NOT NULL,
    store_and_fwd_flag text NOT NULL,
    dropoff_longitude numeric(18,15) NOT NULL,
    dropoff_latitude numeric(18,15) NOT NULL,
    payment_type text NOT NULL,
    fare_amount numeric(9,2) NOT NULL,
    extra numeric(9,2) NOT NULL,
    mta_tax numeric(5,2) NOT NULL,
    tip_amount numeric(9,2) NOT NULL,
    tolls_amount numeric(9,2) NOT NULL,
    improvement_surcharge numeric(9,2) NOT NULL,
    total_amount numeric(9,2) NOT NULL
);

COPY nyc_yellow_taxi_trips (
    vendor_id,
    tpep_pickup_datetime,
    tpep_dropoff_datetime,
    passenger_count,
    trip_distance,
    pickup_longitude,
    pickup_latitude,
    rate_code_id,
    store_and_fwd_flag,
    dropoff_longitude,
    dropoff_latitude,
    payment_type,
    fare_amount,
    extra,
    mta_tax,
    tip_amount,
    tolls_amount,
    improvement_surcharge,
    total_amount
   )
FROM '/home/adrian/gits/practical-sql-2/Chapter_12/nyc_yellow_taxi_trips.csv'
WITH (FORMAT CSV, HEADER);

CREATE INDEX tpep_pickup_idx
ON nyc_yellow_taxi_trips (tpep_pickup_datetime);

-- Count the trip records
SELECT count(*) FROM nyc_yellow_taxi_trips;

-- The Busiest Time of Day
-- exportoval som to do calcu a urobil graf je v share
COPY
	(SELECT
    	date_part('hour', tpep_pickup_datetime) AS trip_hour,
    	count(*)
	FROM nyc_yellow_taxi_trips
	GROUP BY trip_hour
	ORDER BY trip_hour)
TO '/home/adrian/gits/postgreSQL/share/hourly_taxi_pickups.csv'
WITH (FORMAT CSV, HEADER)
-- median
SELECT
    date_part('hour', tpep_pickup_datetime) AS trip_hour,
    percentile_cont(.5)
        WITHIN GROUP (ORDER BY
            tpep_dropoff_datetime - tpep_pickup_datetime) AS median_trip
FROM nyc_yellow_taxi_trips
GROUP BY trip_hour
ORDER BY trip_hour;
----

CREATE TABLE train_rides (
    trip_id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    segment text NOT NULL,
    departure timestamptz NOT NULL,
    arrival timestamptz NOT NULL
);

INSERT INTO train_rides (segment, departure, arrival)
VALUES
    ('Chicago to New York', '2020-11-13 21:30 CST', '2020-11-14 18:23 EST'),
    ('New York to New Orleans', '2020-11-15 14:15 EST', '2020-11-16 19:32 CST'),
    ('New Orleans to Los Angeles', '2020-11-17 13:45 CST', '2020-11-18 9:00 PST'),
    ('Los Angeles to San Francisco', '2020-11-19 10:10 PST', '2020-11-19 21:24 PST'),
    ('San Francisco to Denver', '2020-11-20 9:10 PST', '2020-11-21 18:38 MST'),
    ('Denver to Chicago', '2020-11-22 19:10 MST', '2020-11-23 14:50 CST');

SET TIME ZONE 'US/Central';

SELECT * FROM train_rides;



