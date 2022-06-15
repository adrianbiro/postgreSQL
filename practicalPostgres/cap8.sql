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

CREATE TABLE licenses (
    license_id text,
    first_name text,
    last_name text,
    CONSTRAINT licenses_key PRIMARY KEY (license_id)
);

CREATE TABLE registrations (
    registration_id text,
    registration_date timestamp with time zone,
    license_id text REFERENCES licenses (license_id),
    CONSTRAINT registration_key PRIMARY KEY (registration_id, license_id)
);

INSERT INTO licenses (license_id, first_name, last_name)
VALUES ('T229901', 'Steve', 'Rothery');

INSERT INTO registrations (registration_id, registration_date, license_id)
VALUES ('A203391', '2022-03-17', 'T229901');
-- totoda error lebo licence ID ktore vkladam neexistuje 
INSERT INTO registrations (registration_id, registration_date, license_id)
VALUES ('A75772', '2022-03-17', 'T000001');

-- verzia s ON DELETE CASCADE
CREATE TABLE registrations (
    registration_id text,
    registration_date date,
    license_id text REFERENCES licenses (license_id) ON DELETE CASCADE,
    CONSTRAINT registration_key PRIMARY KEY (registration_id, license_id)
);

-- CHECK Constraint
-- constraint_name CHECK (logical expression)
-- moze ich byt viacero CONSTRAINT grad_check CHECK (credits >= 120 AND tuition = 'Paid')
CREATE TABLE check_constraint_example (
    user_id bigint GENERATED ALWAYS AS IDENTITY,
    user_role text,
    salary numeric(10,2),
    CONSTRAINT user_id_key PRIMARY KEY (user_id),
    CONSTRAINT check_role_in_list CHECK (user_role IN('Admin', 'Staff')),
    CONSTRAINT check_salary_not_below_zero CHECK (salary >= 0)
);

-- obe neprejdu cez CHECK
INSERT INTO check_constraint_example (user_role)
VALUES ('admin');

INSERT INTO check_constraint_example (salary)
VALUES (-10000);

-- UNIQUE constraint
-- value moze byt aj null ale iba raz, preto unique
CREATE TABLE unique_constraint_example (
    contact_id bigint GENERATED ALWAYS AS IDENTITY,
    first_name text,
    last_name text,
    email text,
    CONSTRAINT contact_id_key PRIMARY KEY (contact_id),
    CONSTRAINT email_unique UNIQUE (email)
);

INSERT INTO unique_constraint_example (first_name, last_name, email)
VALUES ('Samantha', 'Lee', 'slee@example.org');

INSERT INTO unique_constraint_example (first_name, last_name, email)
VALUES ('Betty', 'Diaz', 'bdiaz@example.org');
-- toto da error lebo nie je unique email
INSERT INTO unique_constraint_example (first_name, last_name, email)
VALUES ('Sasha', 'Lee', 'slee@example.org');

-- NOT NULL Constraint

CREATE TABLE not_null_example (
    student_id bigint GENERATED ALWAYS AS IDENTITY,
    first_name text NOT NULL,
    last_name text NOT NULL,
    CONSTRAINT student_id_key PRIMARY KEY (student_id)
);

-- error lebo NULL
INSERT INTO not_null_example (first_name, last_name)
VALUES ('Sting', NULL);

/*Daju sa odobrat a neskor zase pridat Constraints
ALTER TABLE table_name DROP CONSTRAINT constraint_name;
ALTER TABLE table_name ALTER COLUMN column_name DROP NOT NULL;
*/
ALTER TABLE not_null_example DROP CONSTRAINT student_id_key;
ALTER TABLE not_null_example ADD CONSTRAINT student_id_key PRIMARY KEY (student_id);
ALTER TABLE not_null_example ALTER COLUMN first_name DROP NOT NULL;
-- SET NOT NULL to da naspak
ALTER TABLE not_null_example ALTER COLUMN first_name SET NOT NULL; 

/*Indexovanie
B-tree (balance tree) je postgres default, automaticky urobi column pre 
primary key ci UNIQ constraint
*/
CREATE TABLE new_york_addresses (
    longitude numeric(9,6),
    latitude numeric(9,6),
    street_number text,
    street text,
    unit text,
    postcode text,
    id integer CONSTRAINT new_york_key PRIMARY KEY
);

COPY new_york_addresses
FROM '/home/adrian/gits/practical-sql-2/Chapter_08/city_of_new_york.csv'
WITH (FORMAT CSV, HEADER);

SELECT * FROM new_york_addresses;

/*porovnanie performance s EXPLAIN*/


EXPLAIN ANALYZE SELECT * FROM new_york_addresses
WHERE street = 'BROADWAY';

EXPLAIN ANALYZE SELECT * FROM new_york_addresses
WHERE street = '52 STREET';

EXPLAIN ANALYZE SELECT * FROM new_york_addresses
WHERE street = 'ZWICKY AVENUE';

-- pridanie indexu zmeni performance
CREATE INDEX street_idx ON new_york_addresses (street);
DROP INDEX street_idx

/* zadanie
*/

CREATE TABLE albums (
    album_id bigint GENERATED ALWAYS AS IDENTITY,
    catalog_code text NOT NULL,
    title text NOT NULL,
    artist text NOT NULL,
    release_date date,
    genre text,
    description text,
	CONSTRAINT album_id_key PRIMARY KEY (album_id),
	CONSTRAINT reles_datte_check CHECK (relese_date > '1/1/1925')
);

CREATE TABLE songs (
    song_id bigint GENERATED ALWAYS AS IDENTITY,
    title text NOT NULL,
    composers text NOT NULL,
    album_id bigint REFERENCES albums (album_id),
	CONSTRAINT song_id_key PRIMARY KEY (song_id)
);




