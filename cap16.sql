/*JSON

*/

CREATE TABLE films (
    id integer GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    film jsonb NOT NULL
);

COPY films (film)
FROM '/home/adrian/gits/practical-sql-2/Chapter_16/films.json';

CREATE INDEX idx_film ON films USING GIN (film);

SELECT * FROM films;
/*
json -> text

jsonb -> text	Extracts a key value, specified as text	json or jsonb (matching the input)
json ->> text

jsonb ->> text	Extracts a key value, specified as text	text
json -> integer

jsonb -> integer	Extracts an array element, specified as an integer denoting its array position	json or jsonb (matching the input)
json ->> integer

jsonb ->> integer	Extracts an array element, specified as an integer denoting its array position	text
json #> text array

jsonb #> text array	Extracts a JSON object at a specified path	json or jsonb (matching the input)
json #>> text array

jsonb #>> text array	Extracts a JSON object at a specified path	text
*/
-- Returns the key value as a JSON data type
SELECT id, film -> 'title' AS title
FROM films
ORDER BY id;

-- Returns the key value as text
SELECT id, film ->> 'title' AS title
FROM films
ORDER BY id;

-- Returns the entire array as a JSON data type
SELECT id, film -> 'genre' AS genre
FROM films
ORDER BY id;

--  Retrieving a JSON array value with element extraction operators 
-- Extracts first element of the JSON array
-- (array elements are indexed from zero, but negative integers count from the end).
SELECT id, film -> 'genre' -> 0 AS genres
FROM films
ORDER BY id;

SELECT id, film -> 'genre' -> -1 AS genres
FROM films
ORDER BY id;

SELECT id, film -> 'genre' -> 2 AS genres
FROM films
ORDER BY id;

-- Return the array element as text
SELECT id, film -> 'genre' ->> 0 AS genres
FROM films
ORDER BY id;

-- Retrieving a JSON key value with path extraction operators

-- Retrieve the film's MPAA rating.
SELECT id, film #> '{rating, MPAA}' AS mpaa_rating
FROM films
ORDER BY id;

-- Retrieve the name of the first character
SELECT id, film #> '{characters, 0, name}' AS name
FROM films
ORDER BY id;

-- Same as above but return it as text
SELECT id, film #>> '{characters, 0, name}' AS name
FROM films
ORDER BY id;


-- JSONB CONTAINMENT AND EXISTENCE OPERATORS

-- Demonstrating the @> containment operator
-- Does the film JSON value contain the following key/value pair?
SELECT id, film ->> 'title' AS title,
       film @> '{"title": "The Incredibles"}'::jsonb AS is_incredible
FROM films
ORDER BY id;

--  Using a containment operator in a WHERE clause

SELECT film ->> 'title' AS title,
       film ->> 'year' AS year
FROM films
WHERE film @> '{"title": "The Incredibles"}'::jsonb; 

-- Listing 16-8: Demonstrating the <@ containment operator

SELECT film ->> 'title' AS title,
       film ->> 'year' AS year
FROM films
WHERE '{"title": "The Incredibles"}'::jsonb <@ film; 

-- Demonstrating existence operators

-- Does the text string exist as a top-level key or array element within the JSON value?
SELECT film ->> 'title' AS title
FROM films
WHERE film ? 'rating';

-- Do any of the strings in the text array exist as top-level keys or array elements?
SELECT film ->> 'title' AS title,
       film ->> 'rating' AS rating,
       film ->> 'genre' AS genre
FROM films
WHERE film ?| '{rating, genre}';

-- Do all of the strings in the text array exist as top-level keys or array elements?
SELECT film ->> 'title' AS title,
       film ->> 'rating' AS rating,
       film ->> 'genre' AS genre
FROM films
WHERE film ?& '{rating, genre}';
