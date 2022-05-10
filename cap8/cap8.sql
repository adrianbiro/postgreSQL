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

-- Creating an Auto-Incrementing Surrogate Key
CREATE TABLE surrogate_key_example (
	order_number BIGINT GENERATED ALWAYS AS IDENTITY,
	product_name TEXT,
	order_time TIMESTAMP WITH TIME ZONE,
	CONSTRAINT order_number_key PRIMARY KEY (order_number)
);

CREATE TABLE surrogate_key_example (
    order_number bigint GENERATED ALWAYS AS IDENTITY,
    product_name text,
    order_time timestamp with time zone,
    CONSTRAINT order_number_key PRIMARY KEY (order_number)
);


INSERT INTO surrogate_key_example (product_name, order_time)
VALUES ('Beachball Polish', '2020-03-15 09:21-07'),
       ('Wrinkle De-Atomizer', '2017-05-22 14:00-07'),
       ('Flux Capacitor', '1985-10-26 01:18:00-07');

SELECT * FROM surrogate_key_example;

--
INSERT INTO surrogate_key_example
OVERRIDING SYSTEM VALUE
VALUES (4, 'Chicken Coop', '2021-09-03 10:33-07');

ALTER TABLE surrogate_key_example ALTER COLUMN order_number RESTART WITH 5;

INSERT INTO surrogate_key_example (product_name, order_time)
VALUES ('Aloe Plant', '2020-03-15 10:09-07');

SELECT * FROM surrogate_key_example;

-- Foreign Keys
-- TODO


