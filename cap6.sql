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

