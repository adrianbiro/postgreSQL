# cli psql
[docs](https://www.postgresql.org/docs/current/app-psql.html)
```
psql -d database_name -U user_name -h hostname_example.com

\?          -- general help
\? options
\? variables
\h          -- list of SQL commands
\h INSERT   -- quasi man page
\q          -- to quit psql shell
\l          -- list databases
\c database_name    -- to switch database
\c database_name user_name
```
```psql
analisys=# CREATE DATABASE test;
CREATE DATABASE
analisys=# \c test
You are now connected to database "test" as user "adrian".
test=#

test=# \c analisys
You are now connected to database "analisys" as user "adrian".
analisys=# DROP DATABASE test;
DROP DATABASE
analisys=#
```


```SQL
SELECT county_name FROM us_counties_pop_est_2019 ORDER BY county_name LIMIT 3;
```
```
    county_name
------------------
 Abbeville County
 Acadia Parish
 Accomack County
(3 rows)
```
Otvori posledny prikaz v $EDITOR, sprava sa to ako bash emacs mod CTRL x CTRL e
```
\e
\edit
```
pager
```psql
analisys=# \pset pager
Pager is used for long output.
analisys=# \pset pager
Pager usage is off.
analisys=# \pset pager
Pager is used for long output.
analisys=#

analisys=# \pset
border                   1
columns                  0
csv_fieldsep             ','
expanded                 off
fieldsep                 '|'
fieldsep_zero            off
footer                   on
format                   aligned
linestyle                ascii
null                     '[null]'
numericlocale            off
pager                    1
pager_min_lines          0
recordsep                '\n'
recordsep_zero           off
tableattr
title
tuples_only              off
unicode_border_linestyle single
unicode_column_linestyle single
unicode_header_linestyle single
analisys=#
```
**vertical list view** \x
```psql
analisys=# SELECT * FROM public.employees ORDER BY emp_id ASC;
 emp_id | first_name | last_name |  salary   | dept_id
--------+------------+-----------+-----------+---------
      1 | Julia      | Reyes     | 115300.00 |       1
      2 | Janet      | King      |  98000.00 |       1
      3 | Arthur     | Pappas    |  72700.00 |       2
      4 | Michael    | Taylor    |  89500.00 |       2
(4 rows)

analisys=# \x
Expanded display is on.
analisys=# SELECT * FROM public.employees ORDER BY emp_id ASC;
-[ RECORD 1 ]---------
emp_id     | 1
first_name | Julia
last_name  | Reyes
salary     | 115300.00
dept_id    | 1
-[ RECORD 2 ]---------
emp_id     | 2
first_name | Janet
last_name  | King
salary     | 98000.00
dept_id    | 1
-[ RECORD 3 ]---------
emp_id     | 3
first_name | Arthur
last_name  | Pappas
salary     | 72700.00
dept_id    | 2
-[ RECORD 4 ]---------
emp_id     | 4
first_name | Michael
last_name  | Taylor
salary     | 89500.00
dept_id    | 2

analisys=#
```
Metadata info
```psql
analisys-# \dt
                         List of relations
 Schema |                  Name                  | Type  |  Owner
--------+----------------------------------------+-------+----------
 public | acs_2014_2018_stats                    | table | postgres
 public | char_data_types                        | table | postgres
 public | current_time_example                   | table | postgres
 public | date_time_types                        | table | postgres
 public | departments                            | table | postgres
        --snip--

analisys-# \dt us*
                  List of relations
 Schema |           Name           | Type  |  Owner
--------+--------------------------+-------+----------
 public | us_counties_2019_top10   | table | postgres
 public | us_counties_pop_est_2010 | table | postgres
 public | us_counties_pop_est_2019 | table | postgres
(3 rows)

analisys-#
```
```
\d [pattern]	Columns, data types, plus other information on objects
\di [pattern]	Indexes and their associated tables
\dt [pattern]	Tables and the account that owns them
\du [pattern]	User accounts and their attributes
\dv [pattern]	Views and the account that owns them
\dx [pattern]	Installed extensions
\l [pattern]	Databases
```
Importing data
```psql
\copy state_regions FROM 'path/to/state_regions.csv' WITH (FORMAT CSV, HEADER);
```
z bashu
```bash
psql -d analysis -U postgres -c 'COPY state_regions FROM 'state_regions.csv' WITH (FORMAT CSV, HEADER);' path/to/state_regions.csv
```
to file
```psql
analisys-# \pset format csv
Output format is csv.
analisys=# SELECT * FROM public.employees ORDER BY emp_id ASC;
emp_id,first_name,last_name,salary,dept_id
1,Julia,Reyes,115300.00,1
2,Janet,King,98000.00,1
3,Arthur,Pappas,72700.00,2
4,Michael,Taylor,89500.00,2

analisys=# \o '/home/adrian/gits/postgreSQL/share/frompsql.csv'
analisys=# SELECT * FROM public.employees ORDER BY emp_id ASC;
analisys=#
```
run from file like jq or sed
```bash
psql -d analisys -U user_name -f cap18.sql
```













