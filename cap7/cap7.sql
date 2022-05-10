/* JOINING
SELECT *
FROM table_a JOIN table_b
ON table_a.key_column = table_b.foreihn_key_column
		-- aky kolvek boolean tu ide <, >, ale nie je to caste 
*/


CREATE TABLE departments (
    dept_id integer,
    dept text,
    city text,
    CONSTRAINT dept_key PRIMARY KEY (dept_id),
    CONSTRAINT dept_city_unique UNIQUE (dept, city)
);

CREATE TABLE employees (
    emp_id integer,
    first_name text,
    last_name text,
    salary numeric(10,2),
    dept_id integer REFERENCES departments (dept_id),
    CONSTRAINT emp_key PRIMARY KEY (emp_id)
);

INSERT INTO departments
VALUES
    (1, 'Tax', 'Atlanta'),
    (2, 'IT', 'Boston');

INSERT INTO employees
VALUES
    (1, 'Julia', 'Reyes', 115300, 1),
    (2, 'Janet', 'King', 98000, 1),
    (3, 'Arthur', 'Pappas', 72700, 2),
    (4, 'Michael', 'Taylor', 89500, 2);
	
SELECT * 
FROM employees JOIN departments
ON employees.dept_id = departments.dept_id
ORDER BY employees.dept_id;

/*JOIN types
JOIN  		-- da z oboch kde sa data zhoduju
LEFT JOIN  	-- vsetko z lavej a z pravej co sa zhoduje
RIGHT JOIN  -- vsetko z pravej a z lavej so sa zhoduje
FULL OUTER JOIN  -- z oboch vsetko a spoji na zhodnom
CROS JOIN  	-- da kazdu moznu kombinaciu riadkov z tabuliek
*/

CREATE TABLE district_2020 (
    id integer CONSTRAINT id_key_2020 PRIMARY KEY,
    school_2020 text
);

CREATE TABLE district_2035 (
    id integer CONSTRAINT id_key_2035 PRIMARY KEY,
    school_2035 text
);

INSERT INTO district_2020 VALUES
    (1, 'Oak Street School'),
    (2, 'Roosevelt High School'),
    (5, 'Dover Middle School'),
    (6, 'Webutuck High School');

INSERT INTO district_2035 VALUES
    (1, 'Oak Street School'),
    (2, 'Roosevelt High School'),
    (3, 'Morrison Elementary'),
    (4, 'Chase Magnet Academy'),
    (6, 'Webutuck High School');

SELECT * 
FROM district_2020 JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2020.id;

SELECT * 
FROM district_2020 JOIN district_2035
USING (id)		-- iba v jednom stlpci bude id 
ORDER BY district_2020.id;

SELECT * 
FROM district_2020 LEFT JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2020.id;

SELECT * 
FROM district_2020 RIGHT JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2020.id;

SELECT * 
FROM district_2020 FULL OUTER JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2020.id;

SELECT * 
FROM district_2020 CROSS JOIN district_2035
ORDER BY district_2020.id, district_2035.id;

/*Using NULL to find rows witch missing values*/

-- tomuto sa hovori anti join na NULL
SELECT * 
FROM district_2020 LEFT JOIN district_2035
ON district_2020.id = district_2035.id
WHERE district_2035.id IS NULL;

SELECT * 
FROM district_2020 RIGHT JOIN district_2035
ON district_2020.id = district_2035.id
WHERE district_2020.id IS NULL;

/*
One-to-One  -- ked nie je duplicitna hodnota v ziadnej tabulke
			-- okres tabulka pre skolstvo a prijem domacnosti, 
			-- spojuje ich spolocny key pre okres/state_id
One-to_Many	-- auta znacka FORD jedna tabulka, toto ma viacero 
			-- zhod v druhej kde su model (Mustang, Bronco, ...)
Many-to-Many - Baseball hrac je na viac poziciach a zadya pozicia 
			-- moze mat viacej hracov. Student je na viacej kurzoch
			- a kurz ma viacej studakov.
*/

SELECT district_2020.id,
       district_2020.school_2020,
       district_2035.school_2035
FROM district_2020 LEFT JOIN district_2035
ON district_2020.id = district_2035.id
ORDER BY district_2020.id;

--- spajania viacero tables

CREATE TABLE district_2020_enrollment (
    id integer,
    enrollment integer
);

CREATE TABLE district_2020_grades (
    id integer,
    grades varchar(10)
);

INSERT INTO district_2020_enrollment
VALUES
    (1, 360),
    (2, 1001),
    (5, 450),
    (6, 927);

INSERT INTO district_2020_grades
VALUES
    (1, 'K-3'),
    (2, '9-12'),
    (5, '6-8'),
    (6, '9-12');

SELECT d20.id,
       d20.school_2020,
       en.enrollment,
       gr.grades
FROM district_2020 AS d20 JOIN district_2020_enrollment AS en
    ON d20.id = en.id
JOIN district_2020_grades AS gr
    ON d20.id = gr.id
ORDER BY d20.id;

/* Kombinovanie query results so SET operatorom
UNION		-- hodne usporiadane lebo kombinuje set teda 
			-- len rozne hodnoty, odstrani duplikat
INTERSECT	-- Da iba tie ktore su v oboch prelinaju sa 
EXCEPT 		-- da len uniq nie tie ktore sa prelinaju
*/

SELECT * FROM district_2020
UNION
SELECT * FROM district_2035
ORDER BY id;

-- toto ukaze aj duplikat
SELECT * FROM district_2020
UNION ALL
SELECT * FROM district_2035
ORDER BY id;

-- 2020 bude value v column year ked je skola 2020 respektive 2035
-- a nazov v column skola
SELECT '2020' AS year,
       school_2020 AS school
FROM district_2020
UNION ALL
SELECT '2035' AS year,
       school_2035
FROM district_2035
ORDER BY school, year;

---
SELECT * FROM district_2020
INTERSECT
SELECT * FROM district_2035
ORDER BY id;
---
SELECT * FROM district_2020
EXCEPT
SELECT * FROM district_2035
ORDER BY id;

-- Performing math on joined Census population estimates tables

CREATE TABLE us_counties_pop_est_2010 (
    state_fips text,                         -- State FIPS code
    county_fips text,                        -- County FIPS code
    region smallint,                         -- Region
    state_name text,                         -- State name
    county_name text,                        -- County name
    estimates_base_2010 integer,             -- 4/1/2010 resident total population estimates base
    CONSTRAINT counties_2010_key PRIMARY KEY (state_fips, county_fips)
);

COPY us_counties_pop_est_2010
FROM '/home/adrian/gits/postgreSQL/cap7/us_counties_pop_est_2010.csv'
WITH (FORMAT CSV, HEADER);

SELECT c2019.county_name,
       c2019.state_name,
       c2019.pop_est_2019 AS pop_2019,
       c2010.estimates_base_2010 AS pop_2010,
       c2019.pop_est_2019 - c2010.estimates_base_2010 AS raw_change,
       round( (c2019.pop_est_2019::numeric - c2010.estimates_base_2010)
           / c2010.estimates_base_2010 * 100, 1 ) AS pct_change  -- percenta zmena tu
FROM us_counties_pop_est_2019 AS c2019
    JOIN us_counties_pop_est_2010 AS c2010
ON c2019.state_fips = c2010.state_fips
    AND c2019.county_fips = c2010.county_fips
ORDER BY pct_change DESC;

-- zadanie
/*ktora county najviac poklesla je to texas moze za to basa, zrusili ju
*/
SELECT c2019.county_name,
       c2019.state_name,
       round( (c2019.pop_est_2019::numeric - c2010.estimates_base_2010)
           / c2010.estimates_base_2010 * 100, 1 ) AS pct_change  -- percenta zmena tu
FROM us_counties_pop_est_2019 AS c2019
    JOIN us_counties_pop_est_2010 AS c2010
ON c2019.state_fips = c2010.state_fips
    AND c2019.county_fips = c2010.county_fips
ORDER BY pct_change ASC
LIMIT 1;

--  

SELECT 	
	u2019.county_name, 
	'2019' AS year,
	u2019.pop_est_2019 AS pop_est
FROM us_counties_pop_est_2019 AS u2019
UNION 
SELECT
	u2010.county_name,
	'2010' AS year, 
	u2010.estimates_base_2010 AS pop_est
FROM us_counties_pop_est_2010 AS u2010
ORDER BY county_name, year;

--
-- TODO popis

SELECT percentile_cont(.5)
       WITHIN GROUP (ORDER BY round( (c2019.pop_est_2019::numeric - c2010.estimates_base_2010)
           / c2010.estimates_base_2010 * 100, 1 )) AS percentile_50th
FROM us_counties_pop_est_2019 AS c2019
    JOIN us_counties_pop_est_2010 AS c2010
ON c2019.state_fips = c2010.state_fips
    AND c2019.county_fips = c2010.county_fips;








