PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE employee (id integer primary key, name text);
INSERT INTO employee VALUES(1,'Nassim Roder');
INSERT INTO employee VALUES(2,'asdim Poder');
INSERT INTO employee VALUES(3,'Max Eisenhardt');
INSERT INTO employee VALUES(4,'Pietro Maximoff');
INSERT INTO employee VALUES(5,'Wanda Maximoff');
INSERT INTO employee VALUES(6,'Mortimer Toynbee');
INSERT INTO employee VALUES(7,'Jason Wyngarde');
COMMIT;
