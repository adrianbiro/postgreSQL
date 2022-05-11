/*Inspectiong and modifying data
*/
CREATE TABLE meat_poultry_egg_establishments (
    establishment_number text CONSTRAINT est_number_key PRIMARY KEY,
    company text,
    street text,
    city text,
    st text,
    zip text,
    phone text,
    grant_date date,
    activities text,
    dbas text
);

COPY meat_poultry_egg_establishments
FROM '/home/adrian/gits/practical-sql-2/Chapter_10/MPI_Directory_by_Establishment_Name.csv'
WITH (FORMAT CSV, HEADER);

CREATE INDEX company_idx ON meat_poultry_egg_establishments (company);

SELECT COUNT(*) FROM meat_poultry_egg_establishments;

-- toto da vsetky duplikatne adr pre company
SELECT company, street, city, st, count(*) AS address_count
FROM meat_poultry_egg_establishments
GROUP BY company, street, city, st
HAVING count(*) > 1
ORDER BY company, street, city, st;

-- missing values

SELECT st, 
       count(*) AS st_count
FROM meat_poultry_egg_establishments
GROUP BY st
ORDER BY st;


SELECT establishment_number,
       company,
       city,
       st,
       zip
FROM meat_poultry_egg_establishments
WHERE st IS NULL;

-- insconsistent data value

-- pri skrolovani si vsimni ze meno spolocnosti je casto zle hlaskovane
SELECT company,
       count(*) AS company_count
FROM meat_poultry_egg_establishments
GROUP BY company
ORDER BY company ASC;

-- zle formatovany zip code
SELECT length(zip),
       count(*) AS length_count
FROM meat_poultry_egg_establishments
GROUP BY length(zip)
ORDER BY length(zip) ASC;
 -- ktore su to staty, chyba je ze chyba 0 ci 00 na zaciatku 
 -- a stu to staky ktore s nou zacinaju, preto je na toto dobre 
 -- pouzit TEXT a nie NUMBER
SELECT st,
       count(*) AS st_count
FROM meat_poultry_egg_establishments
WHERE length(zip) < 5
GROUP BY st
ORDER BY st ASC;

/*
modifying data
ALTER TABLE table ADD COLUMN column data_type;
ALTER TABLE table DROP COLUMN column;
ALTER TABLE table ALTER COLUMN column SET DATA TYPE data_type;
ALTER TABLE table ALTER COLUMN column SET NOT NULL;
ALTER TABLE table ALTER COLUMN column DROP NOT NULL;
*/

-- Viewing Modified Data with RETURNING
/*
UPDATE table
SET column_a = value
RETURNING column_a, column_b, column_c;
*/


-- Backing up a table !!index saneprekopiruje!!
CREATE TABLE meat_poultry_egg_establishments_backup AS
SELECT * FROM meat_poultry_egg_establishments;

SELECT
    (SELECT count(*) FROM meat_poultry_egg_establishments) AS original,
    (SELECT count(*) FROM meat_poultry_egg_establishments_backup) AS backup;


-- opravovanie dat z hore

-- bkp column
ALTER TABLE meat_poultry_egg_establishments ADD COLUMN st_copy text;

UPDATE meat_poultry_egg_establishments
SET st_copy = st;

--Checking values in the st and st_copy columns, ak je rovnako neda nic
SELECT st,
       st_copy
FROM meat_poultry_egg_establishments
WHERE st IS DISTINCT FROM st_copy
ORDER BY st;

-- updating rows missing values

UPDATE meat_poultry_egg_establishments
SET st = 'MN'
WHERE establishment_number = 'V18677A';

UPDATE meat_poultry_egg_establishments
SET st = 'AL'
WHERE establishment_number = 'M45319+P45319';

UPDATE meat_poultry_egg_establishments
SET st = 'WI'
WHERE establishment_number = 'M263A+P263A+V263A'
RETURNING establishment_number, company, city, st, zip;

-- RESTORING ORIGINA VALUE
-- Restoring from the column backup
UPDATE meat_poultry_egg_establishments
SET st = st_copy;

-- Restoring from the table backup
UPDATE meat_poultry_egg_establishments original
SET st = backup.st
FROM meat_poultry_egg_establishments_backup backup
WHERE original.establishment_number = backup.establishment_number; 

-- Updating Values for Consistency

ALTER TABLE meat_poultry_egg_establishments ADD COLUMN company_standard text;

UPDATE meat_poultry_egg_establishments
SET company_standard = company;


UPDATE meat_poultry_egg_establishments
SET company_standard = 'Armour-Eckrich Meats'
WHERE company LIKE 'Armour%'
RETURNING company, company_standard;









