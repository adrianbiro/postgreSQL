--single-column primary key

CREATE TABLE natural_key_example (
	license_id TEXT CONSTRAINT license_key PRIMARY KEY,
	first_name TEXT,
	last_name TEXT
);

DROP TABLE natural_key_example;

CREATE TABLE natural_key_example (
	license_id TEXT,
	first_name TEXT,
	last_name TEXT,
	 CONSTRAINT license_key PRIMARY KEY (license_id)
);


INSERT INTO natural_key_example (license_id, first_name, last_name)
VALUES ('T229901', 'Gem', 'Godfrey');
/* toto da error lebo duplikat
INSERT INTO natural_key_example (license_id, first_name, last_name)
VALUES ('T229901', 'John', 'Mitchell');
*/

-- composite primary key
CREATE TABLE natural_key_composite_example (
	student_id TEXT,
	school_day DATE,
	present BOOLEAN,
	CONSTRAINT student_key PRIMARY KEY (student_id, school_day)
);
-- prve dva nechaju error lebo z oba sa neprlinaju, den je iny
INSERT INTO natural_key_composite_example (student_id, school_day, present)
VALUES(775, '2022-01-22', 'Y');

INSERT INTO natural_key_composite_example (student_id, school_day, present)
VALUES(775, '2022-01-23', 'Y');
--  da duplicate key error tu je aj idcko aj den rovnaky 
INSERT INTO natural_key_composite_example (student_id, school_day, present)
VALUES(775, '2022-01-23', 'N');
