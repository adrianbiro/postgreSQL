qlite3 test.db -- open sqlite and provide a database name

-- Creates a table in the database
-- Primary Key automatically generates values that start at 1 and increase by 1
-- name is a text field that will hold employee names

create table employee (id integer primary key, name text); 


INSERT INTO employee (id, name) VALUES (1, "Nassim Roder");
INSERT INTO employee (name) VALUES ("asdim Poder");
insert into employee (name) values('Max Eisenhardt');
insert into employee (name) values('Pietro Maximoff');
insert into employee (name) values('Wanda Maximoff');
insert into employee (name) values('Mortimer Toynbee');
insert into employee (name) values('Jason Wyngarde');

/*
.tables
employee
select * FROM employee WHERE name == "Wanda Maximoff";
5|Wanda Maximoff

-- In column mode, each record is shown on a separate line with the data aligned in columns

-- headers on shows the column names, if off they wouldn't show
*/
.mode column
.headers on
select * from employee; /* Show all employees

id  name            
--  ----------------
1   Nassim Roder    
2   asdim Poder     
3   Max Eisenhardt  
4   Pietro Maximoff 
5   Wanda Maximoff  
6   Mortimer Toynbee
7   Jason Wyngarde  
*/

-- Changes the width of the columns

.width 15 20


.exit -- Closes the database

sqlite3 test.db -- Reopen database

.tables -- Displays the tables

-- Displays every value on its own line

.mode line
select * from employees;

-- Shows the statements used to create the database. You could also provide a table name to see how that single table was made

.schema 
--CREATE TABLE employee (id integer primary key, name text);
.schema employees

-- You can get a more detailed database view

.mode column
.headers on
select type, name, tbl_name, sql from sqlite_master order by type;
/*
type   name      tbl_name  sql                                                      
-----  --------  --------  ---------------------------------------------------------
table  employee  employee  CREATE TABLE employee (id integer primary key, name text)
*/

-- show the current settings
.show

-- Set NULL to 'NULL'
.nullvalue 'NULL'
.show

-- Change the prompt for SQLite

.prompt 'sqlite3> '
.show

-- export database into SQL format on the screen

.dump

-- output to a file

.output ./Documents/sqlite3Files/employee.sql
.dump
.output stdout -- Restores output to the screen

/*You don't delete a database with any command. You have to delete the file itself

 You can delete a table however*/

drop table employees;
DROP TABLE IF EXISTS employee;
-- import the table then with

.read employees.sql

/* mode is used to change the formatting of the output
OPTIONS FOR MODE : column, csv
html: html table
insert: insert commands used 
list: List without commas
tabs: Tab separated list

How to output a CSV list to a file*/

.mode csv 
.separator ,  -- OR define the separator for the columns
.output ./employee.csv
.separator ,
select * from employees;
.output stdout

-- Output html table

.mode html 
select * from employees;
.output stdout

-- line outputs column name and value

.mode line
select * from employees;
.output stdout

-- Items with double quotes

.mode tcl
select * from employees;
.output stdout

----------------
$ sqlite3 superhumans.db
sqlite> .schema
CREATE TABLE general_power(id integer primary key, power_type text, general_power_desc text);
CREATE TABLE identity(id integer primary key, secret_identity text, character text);
CREATE TABLE power(id integer primary key, power_type_id text, power_desc text, FOREIGN KEY(power_type_id) references general_power(id));
CREATE TABLE superhuman(identity_id integer, power_id_1 integer, power_id_2 integer, power_id_3 integer, FOREIGN KEY(identity_id) references identity(id));


CREATE TABLE
  general_power(
    id integer primary key,
    power_type text,
    general_power_desc text
  );

CREATE TABLE
  identity(
    id integer primary key,
    secret_identity text,
    character text
  );

CREATE TABLE
  power(
    id integer primary key,
    power_type_id text,
    power_desc text,
    FOREIGN KEY(power_type_id) references general_power(id)
  );

CREATE TABLE
  superhuman(
    identity_id integer,
    power_id_1 integer,
    power_id_2 integer,
    power_id_3 integer,
    FOREIGN KEY(identity_id) references identity(id)
  );
/*
Commands end with semicolon
3 types of Values
	a. String literals, which are characters surrounded almost always with single quotes
	b. Numeric literals, which are numbers of any type without quotes
	c. Binary literals are numbers represented as hexidecimals
5 Types in SQLite
	a. integer
	b. real
	c. text
	d. blob
	e. null
1 Primary Key
*/


select * -- The action / verb
from general_power -- The subject of your query
where power_type='Invulnerability'; -- The predicate which describes the subject

CREATE TABLE
  origin_issue (
    id INTEGER PRIMARY KEY,
    comic_name TEXT NOT NULL COLLATE NOCASE,
    -- case insensitive
    issue_number INTEGER NOT NULL DEFAULT '0',
    comic_issn INTEGER UNIQUE CHECK(comic_issn > 0),
    --constrain?
    character_id integer,
    FOREIGN KEY(character_id) REFERENCES identity(id)
  )

-- primary key means this will auto increment by 1 and remain unique
-- NOT NULL means it can't contain a null value
-- COLLATE NOCASE converts upper case characters to lowercase characters when comparing
-- COLLATE BINARY if 2 strings are compared, they are compared using the exact characters
-- COLLATE RTRIM compares just like BINARY except trailing white space is ignored
-- DEFAULT defines a default value to use
-- UNIQUE makes sure that the same number isn't used in this column
-- CHECK sets a rule that all data in the column must obey
-- A FOREIGN KEY in one table references a PRIMARY KEY in another table

-- To add a column 
-- It Can't be UNIQUE, PRIMARY KEY
-- It can't have a default value CURRENT_TIME, CURRENT_DATE, CURRENT_TIMESTAMP, -- or an expression in parentheses
-- If NOT NULL it can't have a NULL value

ALTER TABLE
  origin_issue
ADD
  COLUMN writer TEXT;

-- rename a table

ALTER TABLE 
    origin_issue RENAME TO first_issue;



SELECT id, character 
FROM identity;

select 
    *
from 
    superhuman;

select 
    identity_id
from 
    superhuman
where 
    power_id_1 = 6; 

select
    identity_id
from 
    superhuman
where 
    power_id_2 = 14 
    and power_id_3 = 14; 

select 
    identity_id
from 
    superhuman
where 
    power_id_2 = 14 
    or power_id_3 = 14; 

-- LIKE can be used with % to match a series of characters and zero or more 
-- characters there after

select 
    power_type
from 
    general_power
where 
    power_type LIKE 'Superhuman%';

-- Return all matches for Superhuman followed by an s word

select 
    power_type
from 
    general_power
where 
    power_type LIKE 'Superhuman%s%';

-- Return all matches for Superhuman followed by an s word

select 
    power_type
from 
    general_power
where 
    power_type LIKE 'Superhuman%s%'
    AND power_type NOT LIKE '%strength%';

-- _ can be used to represent any 1 character or space

select 
    power_type
from 
    general_power
where 
    power_type LIKE 'Power_________';

-- ORDER BY allows you to define sorting either DESC or ASC
-- LIMIT allows you to limit your results
-- OFFSET will skip the first number or results 

select 
    power_type, 
    general_power_desc
from 
    general_power
where 
    general_power_desc LIKE '%control%'
ORDER BY 
    power_type ASC, 
    power_type 
LIMIT 
    10 
OFFSET 
    2;

-- You can also use a comma after LIMIT offset_number, limit_number

select 
    power_type,
    general_power_desc
from 
    general_power
where 
    general_power_desc LIKE '%control%'
ORDER BY 
    power_type ASC, 
    power_type 
LIMIT 
    2, 10;

-- You can change the title of columns with AS like this

SELECT 
    power_type AS 'Common Power'
FROM 
    general_power 
    WHERE power_type LIKE 'Superhuman%';

-- Fix Captain Americas Last Name

select
  *
from
  identity;

UPDATE
  identity
SET
  secret_identity = 'Steve Rogers'
WHERE
  id = 2;

-- Use DISTINCT to output the first result and then ignore duplicates
INSERT INTO
  identity (secret_identity, character)
VALUES
  ('Scott Lang', 'Ant-Man');

select
  *
from
  identity;

SELECT
  DISTINCT character
FROM
  identity;

-- DELETE a row in a table
DELETE FROM
  identity
WHERE
  id = 7;

-- SQLites SELECT can also be used to perform numerous Arithmetic, Boolean, 
-- Bitwise, Relational and other Operations

SELECT 
    (1+2) / (6-3) * 10;

SELECT 
    15 % 10;

-- You can perform boolean operations in which 0 is false and any other number 
-- is true

SELECT 1 AND 0, 1 OR 0, NOT 1;

-- Relational Operators all work as well
-- <, <=, >, >=, =, ==, !=, <>

SELECT 1 < 2, 3 >= 2, 1 = 1, 1 <> 2;

-- Other Operators

SELECT 'Super' || 'hero'; -- String concatenation

SELECT 
    'Paul' IN ('Mike', 'Phil', 'Paul');  -- give 0 false

SELECT 'PAUL' 
    OR 'Paul' IN ('Mike', 'Paul');  -- give 1 true

SELECT * FROM identity WHERE character IN ('Iron Man', 'Hulk');

-- GLOB is like LIKE, but it is case sensitive and it uses the UNIX file 
-- globbing syntax

-- Find results that contain super, but not Super

SELECT
  *
FROM
  general_power
WHERE
  general_power_desc GLOB '*super*';

-- Find any match that has 9 characters
SELECT
  *
FROM
  general_power
WHERE
  power_type GLOB '?????????'

-- BETWEEN can be used to make comparisons as well

SELECT 
    * 
FROM
    power
WHERE 
    power_type_id BETWEEN 1 AND 40; 

----------------- Random SQLite Functions

SELECT 
    random(); -- Generate random number

SELECT 
    ABS(RANDOM() % 100); -- Random number between 0 and 100

-- Generate minimum and maximum values from a result

SELECT 
    min(id), 
    max(id)
FROM 
    identity;

SELECT 
    LOWER(secret_identity), 
    UPPER(character)
FROM 
    identity;

SELECT 
    total_changes(); -- Returns the total number of changes made to the 
-- database since it was last opened

SELECT 
    LENGTH('Iron Man'); -- Returns the number of characters in a string

SELECT 
    COUNT(*) 
FROM 
    identity; -- Number of rows in the table

SELECT 
    date(); -- Return the current date ISO YY-mm-dd

SELECT 
    time(); -- Return the current time ISO

SELECT 
    datetime(); -- Return the current date and time

SELECT
  date('now', '-30 days');
-- Get the date 30 days ago

SELECT
  date('now', '-20 months');
-- Get the date 30 days ago

SELECT
  date('now', 'weekday 0');
-- Get the date of the next Sunday

SELECT
  time('now', '-1000 minutes');

SELECT
  time('now', '-1000 seconds');

SELECT
  strftime('%m-%d-%Y');

SELECT
  date(
    'now',
    'start of year',
    '10 months',
    '21 days',
    'weekday 4'
  );
--------------------------------------------------

-- CREATE DATABASE
sqlite3 studentdb.db -- There are no ENUMs in SQLite, so we need a separate table for sex
CREATE TABLE
  sex_type(sex_id TEXT PRIMARY KEY NOT NULL, sex_type INTEGER);

-- Fill the sex_type table
INSERT INTO
  sex_type(sex_id, sex_type)
VALUES
  ('M', 1);

INSERT INTO
  sex_type(sex_id, sex_type)
VALUES
  ('F', 2);

--------
CREATE TABLE
  student(
    name VARCHAR(23) NOT NULL,
    -- VARCHAR is treated as TEXT and 23 is ignored
    sex CHARACTER(1) NOT NULL,
    -- CHARACTER and the length restriction is ignored
    id_number INTEGER PRIMARY KEY AUTOINCREMENT,
    foreign key(sex) references sex_type(sex_id)
  );

--------
-- Creating an ENUM that represents the type of test (Quiz or Test)
CREATE TABLE
  test_type(test_id TEXT PRIMARY KEY NOT NULL, test_type INTEGER);

-- Fill the test_type table
INSERT INTO
  test_type(test_id, test_type)
VALUES
  ('Q', 1);

INSERT INTO
  test_type(test_id, test_type)
VALUES
  ('T', 2);

--------
CREATE TABLE
  test(
    date DATE NOT NULL,
    -- DATE is seen as a NUMERIC type
    type_test TEXT NOT NULL,
    test_id INTEGER PRIMARY KEY AUTOINCREMENT,
    FOREIGN KEY (type_test) REFERENCES test_type (test_id)
  );

CREATE TABLE
  test_score(
    student_id INTEGER NOT NULL,
    test_id INTEGER NOT NULL,
    score INTEGER NOT NULL,
    FOREIGN KEY (test_id) REFERENCES test (test_id),
    FOREIGN KEY (student_id) REFERENCES student (id_number),
    PRIMARY KEY (test_id, student_id)
  );

-- A Composite Primary Key
--------
CREATE TABLE
  absence(
    student_id INTEGER NOT NULL,
    date DATE NOT NULL,
    PRIMARY KEY (student_id, date),
    FOREIGN KEY (student_id) REFERENCES student (id_number)
  );

-------

INSERT INTO
  student (name, sex)
VALUES
  ('Sally', 'F');

INSERT INTO
  student (name, sex)
VALUES
  ('Mark', 'M');

INSERT INTO
  student (name, sex)
VALUES
  ('Paul', 'M');

INSERT INTO
  student (name, sex)
VALUES
  ('Peter', 'M');

INSERT INTO
  student (name, sex)
VALUES
  ('Michael', 'M');

INSERT INTO
  student (name, sex)
VALUES
  ('Thomas', 'M');

INSERT INTO
  student (name, sex)
VALUES
  ('Rebecca', 'F');

INSERT INTO
  student (name, sex)
VALUES
  ('Willow', 'F');

INSERT INTO
  student (name, sex)
VALUES
  ('Sarah', 'F');

INSERT INTO
  student (name, sex)
VALUES
  ('Emily', 'F');

-- date, type_test, test_id
INSERT INTO
  test
VALUES
  (date('now'), 'Q', 1);

-- New Test: NULL for Autoincrement
-- student_id, test_id, score
INSERT INTO
  test_score
VALUES
  (1, 1, 24);

INSERT INTO
  test_score
VALUES
  (2, 1, 22);

INSERT INTO
  test_score
VALUES
  (3, 1, -1);

INSERT INTO
  test_score
VALUES
  (4, 1, 19);

INSERT INTO
  test_score
VALUES
  (5, 1, 25);

INSERT INTO
  test_score
VALUES
  (6, 1, 22);

INSERT INTO
  test_score
VALUES
  (7, 1, 18);

INSERT INTO
  test_score
VALUES
  (8, 1, 16);

INSERT INTO
  test_score
VALUES
  (9, 1, 20);

INSERT INTO
  test_score
VALUES
  (10, 1, 19);

-- student_id, date
INSERT INTO
  absence
VALUES
  (3, date('now'));

-- One student was absent
------- NEW TEST
-- date, type_test, test_id
INSERT INTO
  test
VALUES
  ('2022-06-16', 'T', 2);

-- Put quotes around date
-- student_id, test_id, score
INSERT INTO
  test_score
VALUES
  (1, 2, 48);

INSERT INTO
  test_score
VALUES
  (2, 2, 44);

INSERT INTO
  test_score
VALUES
  (3, 2, 42);

INSERT INTO
  test_score
VALUES
  (4, 2, -1);

INSERT INTO
  test_score
VALUES
  (5, 2, 40);

INSERT INTO
  test_score
VALUES
  (6, 2, 45);

INSERT INTO
  test_score
VALUES
  (7, 2, 50);

INSERT INTO
  test_score
VALUES
  (8, 2, 39);

INSERT INTO
  test_score
VALUES
  (9, 2, -1);

INSERT INTO
  test_score
VALUES
  (10, 2, -1);

-- student_id, date
INSERT INTO
  absence
VALUES
  (4, '2022-06-16');

INSERT INTO
  absence
VALUES
  (9, '2022-06-16');

INSERT INTO
  absence
VALUES
  (10, '2022-06-16');
----------------------------------------------------------------------------------- tu
-- SELECT QUERIES
-- Show test results for all students for the quiz given on 2022-06-16
-- We need to pull this information from 2 tables this time
SELECT
  student_id,
  score,
  type_test,
  date
FROM
  test,
  test_score
WHERE
  date = '2022-06-16'
  AND test.test_id = test_score.test_id;

-- Print out the students name with the scores
-- You have to match the student ids for tables test_score and student
-- That way they will only show the test score that corresponds with each
-- individual student
SELECT
  name,
  score,
  type_test,
  date
FROM
  test,
  test_score,
  student
WHERE
  date = '2022-06-16'
  AND test.test_id = test_score.test_id
  AND test_score.student_id = student.id_number;

-- List all students along with their number of absences
-- Since we are using an aggregate query here to group data we have to define
-- how we want the information to be grouped when it is displayed on the screen.
-- That is why we define id_number as the way to group information. It is saying
-- that we should calculate the number of absences for each id_number.
SELECT
  name AS NAME,
  COUNT(absence.date) AS ABSENCES
FROM
  student,
  absence
WHERE
  absence.student_id = student.id_number
GROUP BY
  id_number;

-- SQLite JOINS
-- Above we defined INNER JOINs by separating tables with a comma. You can also
-- define them with the word INNER JOIN
-- An INNER JOIN is the most common join. An INNER JOIN returns only those
-- records from tables that match. The JOIN CONDITION defines the results.
SELECT
  name,
  score,
  test_id
FROM
  test_score
  JOIN student ON student_id = id_number;

-- To show all students with the number of ansences even if they have none we
-- have to use a LEFT JOIN.
-- The LEFT JOIN says that we need a row for each piece of data listed on the
-- left of the join. Don't forget to change WHERE into ON
SELECT
  name AS NAME,
  COUNT(absence.date) AS ABSENCES
FROM
  student
  LEFT JOIN absence ON absence.student_id = student.id_number
GROUP BY
  id_number;

-- A NATURAL INNER JOIN is similar to a LEFT JOIN in that it returns all columns
-- that match in both tables.
SELECT
  score,
  test_id
FROM
  student
  NATURAL JOIN test_score
WHERE
  student_id = id_number;

-- A CROSS INNER JOIN (Cartesian Join) combines all the records from 2 tables.
-- This can sometimes make a mess and should normally be avoided
SELECT
  score,
  test_id
FROM
  student
  CROSS JOIN test_score;

-- Applying Functions in SQLite
-- Find the Best and Worst Scores on all quizes and tests
-- test_score : student_id, test_id, score
-- test : date, type_test, test_id
-- student : name, sex, id_number
SELECT
  test.date AS DATE,
  MIN(test_score.score) AS WORST,
  MAX(test_score.score) AS BEST
FROM
  test_score,
  test
WHERE
  test_score.test_id = test.test_id
GROUP BY
  test.date;

-- Print the average score on each test
SELECT
  test.date AS DATE,
  AVG(test_score.score) 'AVG SCORE'
FROM
  test_score,
  test
WHERE
  test_score.test_id = test.test_id
GROUP BY
  test.date;

-- List all students that had a test score over 40
SELECT
  name,
  test_score.score
FROM
  test_score,
  student
WHERE
  test_score.score > 40
  AND test_score.student_id = student.id_number
GROUP BY
  name;

SELECT
  COUNT(name) AS 'SCORED OVER 40'
FROM
  student
WHERE
  student.name in (
    SELECT
      name
    FROM
      test_score,
      student
    WHERE
      test_score.score > 40
      AND test_score.student_id = student.id_number
    GROUP BY
      name
  );

-- VIEWS IN SQLite --
-- A view is used to store a queries result. It is not part of the schema
CREATE VIEW
  ScoreOver40 AS
SELECT
  name,
  test_score.score
FROM
  test_score,
  student
WHERE
  test_score.score > 40
  AND test_score.student_id = student.id_number
GROUP BY
  name;

-- sqlite> .tables
select * from ScoreOver40; 

drop view
  ScoreOver40;

-- Delete the view
-- TRIGGERS in SQLite --
-- Triggers are operations that are automatically performed when a specific
-- event occurs
-- test : date, type_test, test_id
-- test_score : student_id, test_id, score
-- student : name, sex, id_number
-- Will Hold Data When a Student Has a Makeup Test
CREATE TABLE
  Log(
    id INTEGER PRIMARY KEY,
    test_id INTEGER NOT NULL,
    date DATE NOT NULL,
    student_id INTEGER NOT NULL,
    FOREIGN KEY (test_id) REFERENCES test_score (test_id),
    FOREIGN KEY (student_id) REFERENCES test_score (student_id)
  );

-- The Trigger that updates the Log when test_score is updated
CREATE TRIGGER
  test_score_update AFTER
UPDATE
  OF score ON test_score BEGIN
INSERT INTO
  Log(test_id, date, student_id)
VALUES
(new.test_id, date('now'), new.student_id);

-- Don't reference table instead use new
END;

select
  *
from
  absence;

-- Show all absences
/*
sqlite> UPDATE test_score SET score = 20
   ...> WHERE test_id = 2
   ...> and student_id =9;
sqlite> SELECT * from L
LAST   LEFT   LIKE   LIMIT  Log    
sqlite> SELECT * from Log;
1|2|2022-06-16|9
sqlite> 
*/





