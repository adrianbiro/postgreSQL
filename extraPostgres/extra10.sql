/*Transakcie
ked sa prelievaju hodnoty z jednej do druhej 
aby bol správny zostatok na obocho stranach.
Ide o to aby nastali naraz
ACID transakcie
Atomicke, Konzistentne, izolovane, durability (trvanlive) 
Atomicita - prikazy su ako jeden celok
Konzistencia - transakcia musí byt pred aj po validna, inak sa neudeje
Izolovane - je mozne prispupovat k TABLE viack krat sucasne a nie je to problem
Durability - ak u bola raz transakcia platna bude platit pri poruche naprikad*/

DROP TABLE IF EXISTS account;

CREATE TABLE account (
	account_id SERIAL PRIMARY KEY,
	username VARCHAR(128) NOT NULL,
	balance INT NOT NULL
);

INSERT INTO account(username, balance) VALUES ('Miso', 120);
INSERT INTO account(username, balance) VALUES ('Jano', 150);
INSERT INTO account(username, balance) VALUES ('Fero', 150);

SELECT * 
FROM account;

/*-- Uloha: chceme aby sa tieto operacie vykonali naraz. Toto dole nie je transakcia
UPDATE account
SET balance=100
WHERE username='Miso';

UPDATE account
SET balance=170
WHERE username='Jano';
*/

/*Tu zacina transakcia musi byt ohranicena BEGIN a COMMIT*/
BEGIN; 
-- alebo BEGIN TRANSACTION;
-- alebo BEIGN WORK;

UPDATE account
SET balance=100
WHERE username='Miso';

UPDATE account
SET balance=170
WHERE username='Jano';

COMMIT;
-- alebo COMMIT TRANSACTION;
-- alebo COMMIT WORK;

SELECT * FROM account;

/*ROLLBACK je dobra poistka ktoru viam pouzit programaticky ak nastane chyba*/
-- Pomocou prikazu ROLLBACK vieme vratit spat transakciu 
BEGIN;

UPDATE account 
SET balance=balance+1000000
WHERE username='Miso';

ROLLBACK;
-- Tato transakcia hore sa nikdy nevykonala 

-- Telo transakcie nie je viditelne conku pokym sa necommitne
BEGIN; 

UPDATE account 
SET balance=balance+1000000
WHERE username='Miso';

SELECT *
FROM account;
-- otvorte si teraz novy query tool a skuste tam dat ten select 
COMMIT;
-- az teraz bude zmena viditelna

DROP TABLE IF EXISTS account;