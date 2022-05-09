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