CREATE TABLE go(
	id_t SERIAL,
	name VARCHAR(500)
);
DROP TABLE IF EXISTS go;

CREATE TABLE teachers (
	id bigserial, /*bigserial postgres specific*/
	first_name varchar(25),
	last_name varchar(50),
	school varchar(50),
	hire_date date,
	salary numeric
);

INSERT INTO teachers (first_name, last_name, school, hire_date, salary)
VALUES ('Janet', 'Smith', 'F.D. Roosevelt HS', '2011-10-30', 36200),
       ('Lee', 'Reynolds', 'F.D. Roosevelt HS', '1993-05-22', 65000),
       ('Samuel', 'Cole', 'Myers Middle School', '2005-08-01', 43500),
       ('Samantha', 'Bush', 'Myers Middle School', '2011-10-30', 36200),
       ('Betty', 'Diaz', 'Myers Middle School', '2005-08-30', 43500),
       ('Kathleen', 'Roush', 'F.D. Roosevelt HS', '2010-10-22', 38500);
	   
	   
SELECT *
FROM teachers
WHERE first_name ILIKE 's%';

ALTER TABLE IF EXISTS teachers
RENAME TO teacher;

SELECT school, salary, last_name
FROM teacher;

SELECT last_name, salary, hire_date
from teacher
ORDER BY salary DESC;
-- ORDER BY 2 DESC; /*to iste co hore zorad podla  2 polozky v poradi*/
	   

SELECT first_name, id, school, hire_date
FROM teacher
ORDER BY school ASC, hire_date DESC;
/*zorad podla skoly a v rovnakej podla salary*/

SELECT DISTINCT school
FROM teacher
ORDER BY school;

/*unique pairs*/
SELECT DISTINCT school, salary
FROM teacher
ORDER BY school, salary;


SELECT last_name, school, hire_date
FRoM teacher
WHERE school = 'Myers Middle School';

/*
	WHERE school = 'Baker Middle'   -- <, >, >=, <=
	WHERE school <> 'Baker Middle'  -- not equal !=
	WHERE salary BETWEEN 20000 AND 40000
	WHERE last_name IN ('Bush', 'Roush')  -- one of values
	WHERE first_name LIKE 'Sam%'  -- patern, ILIKE case insensitive, NOT ILIKE negates condition
	-- % one or more character
	-- _ just one character
*/

SELECT first_name, last_name, school
FROM teacher
WHERE first_name = 'Janet';

SELECT school
FROM teacher
WHERE school <> 'F.D. Roosevelt HS';

SELECT first_name, last_name, hire_date
FROM teacher
WHERE hire_date < '2000-01-01';

SELECT first_name, last_name, salary
FROM teacher
WHERE salary >= 43500;

SELECT first_name, last_name, school, salary
FROM teacher
WHERE salary BETWEEN 40000 AND 65000;

SELECT first_name, last_name, school, salary
FROM teacher
WHERE salary >= 40000 AND salary <= 65000;

SELECT first_name
FROM teacher
--WHERE first_name LIKE 'Sam%'
--WHERE first_name ILIKE 'sam%'
--WHERE first_name LIKE 'S_m%'  /*Samuel Samantha aj tie hore*/
WHERE first_name ILIKE 's_%l'  /*Samuel*/

/*
Combining Operators with AND adn OR
*/

SELECT * 
FROM teacher
WHERE school = 'Myers Middle School'
	AND salary < 40000;

SELECT *
FROM teacher
WHERE last_name = 'Cole'
	OR last_name = 'Bush';

SELECT *
FROM teacher
WHERE school = 'F.D. Roosevelt HS'
	AND (salary < 38000 OR salary > 40000);  -- parantheses for order of operations

/*
SELECT column_names
FROM table_name
WHERE criteria
ORDeR BY column_names;
*/

SELECT first_name, last_name, school, hire_date, salary
FROM teacher
WHERE school LIKE '%Roos%'
ORDER BY hire_date DESC;

SELECT school, last_name
FROM teacher
ORDER BY school, last_name;

SELECT first_name, last_name, salary
FROM teacher
WHERE salary > 40000
	AND first_name LIKE 'S%';

select * FROM teacher;

SELECT last_name, hire_date, salary
FROM teacher
WHERE hire_date > '2010-1-1'
ORDER BY salary DESC;








