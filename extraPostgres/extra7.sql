CREATE TABLE IF NOT EXISTS person (
    person_id SERIAL PRIMARY KEY,
    fname VARCHAR(50) UNIQUE NOT NULL,
    lname VARCHAR(50) NOT NULL,
    age INT,
    date_of_join TIMESTAMP DEFAULT '2000-01-16 19:10:25-07',
    is_real BOOL DEFAULT FALSE
    
);

DROP TABLE IF EXISTS person;

INSERT INTO person
    (fname, lname, age)
VALUES
    (N'Joji', N'Nasieeeaný', 4),
    (N'Joj4', N'Nas222ianý', 19),
    (N'Joje', N'Nasiawwwný', 41),
    (N'Jojd', N'Naeeesianý', 2),
    (N'Joja', N'swa', 17);

INSERT INTO person
    (fname, lname, age, date_of_join, is_real)
VALUES
    (N'As', N'SA', 8, '2021-01-16 19:10:25-07', TRUE),
    (N'Au', N'SyA', 15, '2081-01-16 18:10:25-07', TRUE);

SELECT * FROM person;

/* Case statment */
SELECT p.person_id,
        p.fname,
        p.age,
        CASE
            WHEN p.age < 18 THEN 'below 18'  -- honota bude tento text
            WHEN p.age >= 18 THEN '18 or more'
        END AS "Age"  -- novy riadok bude sa volat Age
FROM person AS p;

/* Meno zacina na a alebo A */
SELECT p.person_id,
        p.fname
FROM person AS p
		WHERE p.fname ILIKE 'a%';

