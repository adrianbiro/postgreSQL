CREATE TABLE IF NOT EXISTS student (
	student_id SERIAL PRIMARY KEY,
	username VARCHAR(128) NOT NULL
);

DROP TABLE IF EXISTS student;

CREATE TABLE IF NOT EXISTS "Student" (
	student_id SERIAL PRIMARY KEY,
	"Username" VARCHAR(128) UNIQUE NOT NULL,
	password VARCHAR (128) NOT NULL,
	year_born TIMESTAMP NOT NULL,
	updated_on TIMESTAMP
);

DROP TABLE IF EXISTS "Student";

CREATE TABLE IF NOT EXISTS employee (
	employee_id SERIAL PRIMARY KEY,
	name VARCHAR (128) UNIQUE NOT NULL,
	in_core BOOLEAN NOT NULL DEFAULT FALSE,
	year_born TIMESTAMP NOT NULL,
	in_company_since DATE NOT NULL,
	email VARCHAR (50), --DEFAULT name@commail.io 
	updates_on TIMESTAMP
);
DROP TABLE IF EXISTS employee;

CREATE TABLE IF NOT EXISTS student (
	student_id SERIAL PRIMARY KEY,
	username VARCHAR(128) UNIQUE NOT NULL,
	password VARCHAR (128) NOT NULL,
	is_new BOOLEAN,
	year_born TIMESTAMP NOT NULL,
	updated_on TIMESTAMP
);
DROP TABLE IF EXISTS student;

--TODO

INSERT INTO student(username, "password", is_new, year_born, updated_on)
VALUES ('Ado', 'Heslo', TRUE, 1885, '2022-04-26 19:57:25-07');
