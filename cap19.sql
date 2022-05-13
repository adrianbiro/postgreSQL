CREATE TABLE vacuum_test (
    integer_column integer
);

SELECT pg_size_pretty(
           pg_total_relation_size('vacuum_test')
       );
       
       
SELECT pg_size_pretty(
           pg_total_relation_size('vacuum_test')
       );
       
-- na psql
analisys=# \dt+ vacuum_test 


-- add data prida to 17 MB
INSERT INTO vacuum_test
SELECT * FROM generate_series(1,500000);
-- update value je to na 35 MB
UPDATE vacuum_test
SET integer_column = integer_column + 1;


-- Viewing autovacuum statistics for vacuum_test

SELECT relname,
       last_vacuum,
       last_autovacuum,
       vacuum_count,
       autovacuum_count
FROM pg_stat_all_tables
WHERE relname = 'vacuum_test';

-- To see all columns available
SELECT *
FROM pg_stat_all_tables
WHERE relname = 'vacuum_test';

-- Running VACUUM manually

VACUUM vacuum_test;

VACUUM; -- vacuums the whole database

VACUUM VERBOSE; -- provides messages

-- Using VACUUM FULL to reclaim disk space

VACUUM FULL vacuum_test;

-- zase bude 17
SELECT pg_size_pretty(
           pg_table_size('vacuum_test')
       );
       
-- SETTINGS
-- Showing the location of postgresql.conf
SHOW config_file;

-- Showing the location of the data directory
SHOW data_directory;

-- Reload settings using pg_ctl:  --TODO z najakeho dovodu mam man ale nie binary
pg_ctl reload -D '/var/lib/postgresql/13/main'

-- Reload settings using pg_reload_conf():
SELECT pg_reload_conf(); 


-- BACKUP AND RESTORE

-- Exporting the analysis database with pg_dump
pg_dump -d analysis -U [user_name] -Fc -v -f analysis_backup.dump

-- Export just a table
pg_dump -t 'train_rides' -d analysis -U [user_name] -Fc -v -f train_backup.dump

-- Restoring the analysis database with pg_restore

pg_restore -C -d postgres -U postgres analysis_backup.dump

CREATE DATABASE zmazma;
DROP DATABASE zmazma;

