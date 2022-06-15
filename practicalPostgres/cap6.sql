/*SQL math

+
-
*
/
%		modulo
^		exponentiation
|\		square root
||/ 	Cube root
!		factorial

*/
-- postgres mysql, microsoft sql server vedia 
-- jednoduche pocitanie bez specifikovania tabulky
SELECT 2 + 2;
SELECT 2 * 9;
SELECT 11 / 6; -- da 1 pozor
SELECT 11 % 6;
SELECT 11 % 2;
SELECT 11.0 / 6; -- treba specifikovat float a da to 1.833333333
SELECT CAST(11 AS numeric(3,1)) / 6;

SELECT 3 ^ 4;

SELECT |/ 10;
SELECT sqrt(10)

SElECT ||/ 10;

SELECT factorial(4)
SELECT 4 !; -- toto je od postgres 13 hore

SELECT 7 + 8 * 9;
SELECT (7 + 8) * 9;

SELECT 3 ^ 3 - 1;
SELECT 3 ^ (3 - 1);

------

SELECT county_name AS county,
       state_name AS state,
       pop_est_2019 AS pop,
       births_2019 AS births,
       deaths_2019 AS deaths,
       international_migr_2019 AS int_migr,
       domestic_migr_2019 AS dom_migr,
       residual_2019 AS residual
FROM us_counties_pop_est_2019;

----
SELECT county_name AS county,
       state_name AS state,
       births_2019 AS births,
       deaths_2019 AS deaths,
       births_2019 - deaths_2019 AS natural_increase  -- narodenie - umrtia
FROM us_counties_pop_est_2019
ORDER BY state_name, county_name;


SELECT county_name AS county,
       state_name AS state,
       pop_est_2019 AS pop,
       pop_est_2018 + births_2019 - deaths_2019 + 
           international_migr_2019 + domestic_migr_2019 +
           residual_2019 AS components_total,
       pop_est_2019 - (pop_est_2018 + births_2019 - deaths_2019 + 
           international_migr_2019 + domestic_migr_2019 +
           residual_2019) AS difference
FROM us_counties_pop_est_2019
ORDER BY difference DESC;
------------

SELECT county_name AS county,
       state_name AS state,
       area_water::numeric / (area_land + area_water) * 100 AS pct_water
FROM us_counties_pop_est_2019
ORDER BY pct_water DESC;
----
/*percent change
formula
(new_number - old_number) / old_number
*/
 CREATE TABLE percent_change (
 	department TEXT,
	 spend_2019 NUMERIC(10,2),
	 spend_2022 NUMERIC(10,2)
 );
 
 INSERT INTO percent_change 
 VALUES
     ('Assessor', 178556, 179500),
    ('Building', 250000, 289000),
    ('Clerk', 451980, 650000),
    ('Library', 87777, 90001),
    ('Parks', 250000, 223000),
    ('Water', 199000, 195000);
 
 
 
SELECT department,
 		spend_2019,
		spend_2022,
		ROUND((spend_2022 - spend_2019) / spend_2019 * 100, 1) AS pct_change
FROM percent_change;
 
 /*Aggregate Functions of Averages and Sums
 */
SELECT SUM(pop_est_2019) AS county_sum,
 		ROUND(AVG(pop_est_2019), 0) AS county_average
FROM us_counties_pop_est_2019;

/*Median
na rozdiel od excelu nema sql nativnu median funkciu robi sa to cey percentile
*/
CREATE TABLE percentile_test (
	numbers INTEGER
);
INSERT INTO percentile_test
VALUES (1), (2), (3), (4), (5), (6);

SELECT
 	PERCENTILE_CONT(.5)  -- .5 je 50th percentile, equivalent to median
	WITHIN GROUP (ORDER BY numbers),
	PERCENTILE_DISC(.5)
	WITHIN GROUP (ORDER BY numbers)
FROM percentile_test;
 
SELECT SUM(pop_est_2019) AS county_sum,
       ROUND(AVG(pop_est_2019), 0) AS county_average,
       PERCENTILE_CONT(.5)
       WITHIN GROUP (ORDER BY pop_est_2019) AS county_median
FROM us_counties_pop_est_2019;

/*
PERCENTILE_CONT(.25)  -- da lowest 25 percent of data
*/
-- da to spodnu stvrtinu median a hornu stvrtinu
SELECT percentile_cont(ARRAY[.25,.5,.75])  -- value sa da zadat ako array a da to CSV v {}
       WITHIN GROUP (ORDER BY pop_est_2019) AS quartiles
FROM us_counties_pop_est_2019;


-- quintiles
SELECT percentile_cont(ARRAY[.2,.4,.6,.8])
       WITHIN GROUP (ORDER BY pop_est_2019) AS quintiles
FROM us_counties_pop_est_2019;

-- deciles
SELECT percentile_cont(ARRAY[.1,.2,.3,.4,.5,.6,.7,.8,.9])
       WITHIN GROUP (ORDER BY pop_est_2019) AS deciles
FROM us_counties_pop_est_2019;

-- Using unnest() to turn an array into rows

SELECT UNNEST(
            percentile_cont(ARRAY[.25,.5,.75])
            WITHIN GROUP (ORDER BY pop_est_2019)
            ) AS quartiles
FROM us_counties_pop_est_2019;

-- Finding the most-frequent value with mode()

SELECT MODE() WITHIN GROUP (ORDER BY births_2019)
FROM us_counties_pop_est_2019;

-- TODO uloha
/* objem kruhu 
2 * pi * r
plocha
pi * r na druhu
*/
SELECT 2 * 3.14 * 5;
SELECT 3.14 * (5 ^ 2);


SELECT county_name AS "NY_county", 
	births_2019, deaths_2019,
	births_2019 - deaths_2019 AS natural_increase
FROM us_counties_pop_est_2019
WHERE state_name = 'New York'
ORDER BY natural_increase DESC
