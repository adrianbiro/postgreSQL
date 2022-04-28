DROP TABLE IF EXISTS test1;
DROP TABLE IF EXISTS test2;

CREATE TABLE test1 (
    user_id_test1 INT PRIMARY KEY,
    username VARCHAR (100) NOT NULL
);

CREATE TABLE test2 (
    user_id_test2 INT PRIMARY KEY,
	username VARCHAR (100) NOT NULL
);

INSERT INTO test1 (user_id_test1, username)
VALUES
    (1, 'Jano'),
    (2, 'Miso'),
    (3, 'Fero'),
    (4, 'Juro'),
	(5, 'Palo'),
	(6, 'Matej');

INSERT INTO test2 (user_id_test2, username)
VALUES
    (1, 'Fero'),
    (2, 'Palo'),
    (3, 'Miso'),
    (4, 'Karol'),
	(5, 'Patrik'),
	(6, 'Matej');
	

SELECT *
FROM test1;

SELECT *
FROM test2;

-- INNER JOIN/JOIN
-- iba spolocne pre obe tab
SELECT * 
FROM test1
INNER JOIN test2
	ON test1.username=test2.username

-- LEFT JOIN/LEFT OUTER JOIN
-- ukaz celu prvu a ak ma par v druhej na pravo tak ten par
SELECT * 
FROM test1
LEFT JOIN test2
	ON test1.username=test2.username
	
-- RIGHT JOIN/RIGHT OUTER JOIN 
-- to ale na opak
SELECT * 
FROM test1
RIGHT JOIN test2
	ON test1.username=test2.username
-- Table from which you are taking data is 'LEFT'.
-- Table you are joining is 'RIGHT'.
-- LEFT JOIN: Take all items from left table AND (only) matching items from right table.
-- RIGHT JOIN: Take all items from right table AND (only) matching items from left table.


-- zorad zhodne, ked je unikum daj null
SELECT * 
FROM test1
FULL OUTER JOIN test2
	ON test1.username=test2.username
	
-- CROS JOIN Toto je specialny pripad takzvany karteziansky sucin kde kombinujeme 
-- kazdy zaznam s kazdym 
-- mnozina vsetkych dvojic a ich usporiadani teda 12 a 21 sa tam objavi 
-- nie je to ako kombinatorika ze len uniq kombo,
SELECT * 
FROM test1
CROSS JOIN test2


-- UNION nahodne usporiadane zjednotene mnoziny asi?
SELECT *
FROM test1
UNION 
SELECT *
FROM test2


-- pocet stlpcov a datovy typ musia byt tie iste toto da chybu
DROP TABLE IF EXISTS test3;
CREATE TABLE test3 (
    user_id_test3 INT PRIMARY KEY,
	username VARCHAR (100) NOT NULL,
	car varchar(256) NOT NULL
);

INSERT INTO test3 (user_id_test3, username, car)
VALUES
    (1, 'Jano', 'BMW'),
    (2, 'Miso', 'BMW'),
    (3, 'Fero', 'BMW');
	
-- SELECT *
-- FROM test1
-- UNION 
-- SELECT *
-- FROM test3
-- TOTO spravi chybu
-- UNION maze dupllikaty vo vysledku ak ichc chceme zachovat musime pouzit UNION ALL

--INTERSECT prienik iba to co je v oboch a ma rovnake id a podobne
SELECT *
FROM test1
INTERSECT 
SELECT *
FROM test2

-- EXCEPT zvysok co sa nezhoduje 
-- teda select minus to co sa zhoduje
SELECT *
FROM test1
EXCEPT 
SELECT *
FROM test2

-- Na konci zmazeme tabulky
DROP TABLE IF EXISTS test1;
DROP TABLE IF EXISTS test2;
-----
-----



DROP TABLE IF EXISTS "Customer" CASCADE;
DROP TABLE IF EXISTS "Invoice" CASCADE;

CREATE TABLE "Customer"
(
    "CustomerId" INT NOT NULL,
    "FirstName" VARCHAR(40) NOT NULL,
    "LastName" VARCHAR(20) NOT NULL,
    "Company" VARCHAR(80),
    "Address" VARCHAR(70),
    "City" VARCHAR(40),
    "State" VARCHAR(40),
    "Country" VARCHAR(40),
    "PostalCode" VARCHAR(10),
    "Phone" VARCHAR(24),
    "Fax" VARCHAR(24),
    "Email" VARCHAR(60) NOT NULL,
    "SupportRepId" INT,
    CONSTRAINT "PK_Customer" PRIMARY KEY  ("CustomerId")
);


CREATE TABLE "Invoice"
(
    "InvoiceId" INT NOT NULL,
    "CustomerId" INT NOT NULL,
    "InvoiceDate" TIMESTAMP NOT NULL,
    "BillingAddress" VARCHAR(70),
    "BillingCity" VARCHAR(40),
    "BillingState" VARCHAR(40),
    "BillingCountry" VARCHAR(40),
    "BillingPostalCode" VARCHAR(10),
    "Total" NUMERIC(10,2) NOT NULL,
    CONSTRAINT "PK_Invoice" PRIMARY KEY  ("InvoiceId")
);


ALTER TABLE "Invoice" ADD CONSTRAINT "FK_InvoiceCustomerId"
    FOREIGN KEY ("CustomerId") REFERENCES "Customer" ("CustomerId") ON DELETE NO ACTION ON UPDATE NO ACTION;
	

INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Company", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email", "SupportRepId") VALUES (1, N'Luís', N'Gonçalves', N'Embraer - Empresa Brasileira de Aeronáutica S.A.', N'Av. Brigadeiro Faria Lima, 2170', N'São José dos Campos', N'SP', N'Brazil', N'12227-000', N'+55 (12) 3923-5555', N'+55 (12) 3923-5566', N'luisg@embraer.com.br', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (2, N'Leonie', N'Köhler', N'Theodor-Heuss-Straße 34', N'Stuttgart', N'Germany', N'70174', N'+49 0711 2842222', N'leonekohler@surfeu.de', 5);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (3, N'François', N'Tremblay', N'1498 rue Bélanger', N'Montréal', N'QC', N'Canada', N'H2G 1A7', N'+1 (514) 721-4711', N'ftremblay@gmail.com', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (4, N'Bjørn', N'Hansen', N'Ullevålsveien 14', N'Oslo', N'Norway', N'0171', N'+47 22 44 22 22', N'bjorn.hansen@yahoo.no', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Company", "Address", "City", "Country", "PostalCode", "Phone", "Fax", "Email", "SupportRepId") VALUES (5, N'Frantiek', N'Wichterlová', N'JetBrains s.r.o.', N'Klanova 9/506', N'Prague', N'Czech Republic', N'14700', N'+420 2 4172 5555', N'+420 2 4172 5555', N'frantisekw@jetbrains.com', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (6, N'Helena', N'Holý', N'Rilská 3174/6', N'Prague', N'Czech Republic', N'14300', N'+420 2 4177 0449', N'hholy@gmail.com', 5);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (7, N'Astrid', N'Gruber', N'Rotenturmstraße 4, 1010 Innere Stadt', N'Vienne', N'Austria', N'1010', N'+43 01 5134505', N'astrid.gruber@apple.at', 5);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (8, N'Daan', N'Peeters', N'Grétrystraat 63', N'Brussels', N'Belgium', N'1000', N'+32 02 219 03 03', N'daan_peeters@apple.be', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (9, N'Kara', N'Nielsen', N'Sønder Boulevard 51', N'Copenhagen', N'Denmark', N'1720', N'+453 3331 9991', N'kara.nielsen@jubii.dk', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Company", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email", "SupportRepId") VALUES (10, N'Eduardo', N'Martins', N'Woodstock Discos', N'Rua Dr. Falcão Filho, 155', N'São Paulo', N'SP', N'Brazil', N'01007-010', N'+55 (11) 3033-5446', N'+55 (11) 3033-4564', N'eduardo@woodstock.com.br', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Company", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email", "SupportRepId") VALUES (11, N'Alexandre', N'Rocha', N'Banco do Brasil S.A.', N'Av. Paulista, 2022', N'São Paulo', N'SP', N'Brazil', N'01310-200', N'+55 (11) 3055-3278', N'+55 (11) 3055-8131', N'alero@uol.com.br', 5);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Company", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email", "SupportRepId") VALUES (12, N'Roberto', N'Almeida', N'Riotur', N'Praça Pio X, 119', N'Rio de Janeiro', N'RJ', N'Brazil', N'20040-020', N'+55 (21) 2271-7000', N'+55 (21) 2271-7070', N'roberto.almeida@riotur.gov.br', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email", "SupportRepId") VALUES (13, N'Fernanda', N'Ramos', N'Qe 7 Bloco G', N'Brasília', N'DF', N'Brazil', N'71020-677', N'+55 (61) 3363-5547', N'+55 (61) 3363-7855', N'fernadaramos4@uol.com.br', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Company", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email", "SupportRepId") VALUES (14, N'Mark', N'Philips', N'Telus', N'8210 111 ST NW', N'Edmonton', N'AB', N'Canada', N'T6G 2C7', N'+1 (780) 434-4554', N'+1 (780) 434-5565', N'mphilips12@shaw.ca', 5);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Company", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email", "SupportRepId") VALUES (15, N'Jennifer', N'Peterson', N'Rogers Canada', N'700 W Pender Street', N'Vancouver', N'BC', N'Canada', N'V6C 1G8', N'+1 (604) 688-2255', N'+1 (604) 688-8756', N'jenniferp@rogers.ca', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Company", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email", "SupportRepId") VALUES (16, N'Frank', N'Harris', N'Google Inc.', N'1600 Amphitheatre Parkway', N'Mountain View', N'CA', N'USA', N'94043-1351', N'+1 (650) 253-0000', N'+1 (650) 253-0000', N'fharris@google.com', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Company", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email", "SupportRepId") VALUES (17, N'Jack', N'Smith', N'Microsoft Corporation', N'1 Microsoft Way', N'Redmond', N'WA', N'USA', N'98052-8300', N'+1 (425) 882-8080', N'+1 (425) 882-8081', N'jacksmith@microsoft.com', 5);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email", "SupportRepId") VALUES (18, N'Michelle', N'Brooks', N'627 Broadway', N'New York', N'NY', N'USA', N'10012-2612', N'+1 (212) 221-3546', N'+1 (212) 221-4679', N'michelleb@aol.com', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Company", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email", "SupportRepId") VALUES (19, N'Tim', N'Goyer', N'Apple Inc.', N'1 Infinite Loop', N'Cupertino', N'CA', N'USA', N'95014', N'+1 (408) 996-1010', N'+1 (408) 996-1011', N'tgoyer@apple.com', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (20, N'Dan', N'Miller', N'541 Del Medio Avenue', N'Mountain View', N'CA', N'USA', N'94040-111', N'+1 (650) 644-3358', N'dmiller@comcast.com', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (21, N'Kathy', N'Chase', N'801 W 4th Street', N'Reno', N'NV', N'USA', N'89503', N'+1 (775) 223-7665', N'kachase@hotmail.com', 5);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (22, N'Heather', N'Leacock', N'120 S Orange Ave', N'Orlando', N'FL', N'USA', N'32801', N'+1 (407) 999-7788', N'hleacock@gmail.com', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (23, N'John', N'Gordon', N'69 Salem Street', N'Boston', N'MA', N'USA', N'2113', N'+1 (617) 522-1333', N'johngordon22@yahoo.com', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (24, N'Frank', N'Ralston', N'162 E Superior Street', N'Chicago', N'IL', N'USA', N'60611', N'+1 (312) 332-3232', N'fralston@gmail.com', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (25, N'Victor', N'Stevens', N'319 N. Frances Street', N'Madison', N'WI', N'USA', N'53703', N'+1 (608) 257-0597', N'vstevens@yahoo.com', 5);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (26, N'Richard', N'Cunningham', N'2211 W Berry Street', N'Fort Worth', N'TX', N'USA', N'76110', N'+1 (817) 924-7272', N'ricunningham@hotmail.com', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (27, N'Patrick', N'Gray', N'1033 N Park Ave', N'Tucson', N'AZ', N'USA', N'85719', N'+1 (520) 622-4200', N'patrick.gray@aol.com', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (28, N'Julia', N'Barnett', N'302 S 700 E', N'Salt Lake City', N'UT', N'USA', N'84102', N'+1 (801) 531-7272', N'jubarnett@gmail.com', 5);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (29, N'Robert', N'Brown', N'796 Dundas Street West', N'Toronto', N'ON', N'Canada', N'M6J 1V1', N'+1 (416) 363-8888', N'robbrown@shaw.ca', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (30, N'Edward', N'Francis', N'230 Elgin Street', N'Ottawa', N'ON', N'Canada', N'K2P 1L7', N'+1 (613) 234-3322', N'edfrancis@yachoo.ca', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (31, N'Martha', N'Silk', N'194A Chain Lake Drive', N'Halifax', N'NS', N'Canada', N'B3S 1C5', N'+1 (902) 450-0450', N'marthasilk@gmail.com', 5);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (32, N'Aaron', N'Mitchell', N'696 Osborne Street', N'Winnipeg', N'MB', N'Canada', N'R3L 2B9', N'+1 (204) 452-6452', N'aaronmitchell@yahoo.ca', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (33, N'Ellie', N'Sullivan', N'5112 48 Street', N'Yellowknife', N'NT', N'Canada', N'X1A 1N6', N'+1 (867) 920-2233', N'ellie.sullivan@shaw.ca', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "Phone", "Email", "SupportRepId") VALUES (34, N'João', N'Fernandes', N'Rua da Assunção 53', N'Lisbon', N'Portugal', N'+351 (213) 466-111', N'jfernandes@yahoo.pt', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "Phone", "Email", "SupportRepId") VALUES (35, N'Madalena', N'Sampaio', N'Rua dos Campeões Europeus de Viena, 4350', N'Porto', N'Portugal', N'+351 (225) 022-448', N'masampaio@sapo.pt', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (36, N'Hannah', N'Schneider', N'Tauentzienstraße 8', N'Berlin', N'Germany', N'10789', N'+49 030 26550280', N'hannah.schneider@yahoo.de', 5);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (37, N'Fynn', N'Zimmermann', N'Berger Straße 10', N'Frankfurt', N'Germany', N'60316', N'+49 069 40598889', N'fzimmermann@yahoo.de', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (38, N'Niklas', N'Schröder', N'Barbarossastraße 19', N'Berlin', N'Germany', N'10779', N'+49 030 2141444', N'nschroder@surfeu.de', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (39, N'Camille', N'Bernard', N'4, Rue Milton', N'Paris', N'France', N'75009', N'+33 01 49 70 65 65', N'camille.bernard@yahoo.fr', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (40, N'Dominique', N'Lefebvre', N'8, Rue Hanovre', N'Paris', N'France', N'75002', N'+33 01 47 42 71 71', N'dominiquelefebvre@gmail.com', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (41, N'Marc', N'Dubois', N'11, Place Bellecour', N'Lyon', N'France', N'69002', N'+33 04 78 30 30 30', N'marc.dubois@hotmail.com', 5);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (42, N'Wyatt', N'Girard', N'9, Place Louis Barthou', N'Bordeaux', N'France', N'33000', N'+33 05 56 96 96 96', N'wyatt.girard@yahoo.fr', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (43, N'Isabelle', N'Mercier', N'68, Rue Jouvence', N'Dijon', N'France', N'21000', N'+33 03 80 73 66 99', N'isabelle_mercier@apple.fr', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (44, N'Terhi', N'Hämäläinen', N'Porthaninkatu 9', N'Helsinki', N'Finland', N'00530', N'+358 09 870 2000', N'terhi.hamalainen@apple.fi', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Email", "SupportRepId") VALUES (45, N'Ladislav', N'Kovács', N'Erzsébet krt. 58.', N'Budapest', N'Hungary', N'H-1073', N'ladislav_kovacs@apple.hu', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "Phone", "Email", "SupportRepId") VALUES (46, N'Hugh', N'O''Reilly', N'3 Chatham Street', N'Dublin', N'Dublin', N'Ireland', N'+353 01 6792424', N'hughoreilly@apple.ie', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (47, N'Lucas', N'Mancini', N'Via Degli Scipioni, 43', N'Rome', N'RM', N'Italy', N'00192', N'+39 06 39733434', N'lucas.mancini@yahoo.it', 5);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (48, N'Johannes', N'Van der Berg', N'Lijnbaansgracht 120bg', N'Amsterdam', N'VV', N'Netherlands', N'1016', N'+31 020 6223130', N'johavanderberg@yahoo.nl', 5);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (49, N'Stanislaw', N'Wójcik', N'Ordynacka 10', N'Warsaw', N'Poland', N'00-358', N'+48 22 828 37 39', N'stanislaw.wójcik@wp.pl', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (50, N'Enrique', N'Muñoz', N'C/ San Bernardo 85', N'Madrid', N'Spain', N'28015', N'+34 914 454 454', N'enrique_munoz@yahoo.es', 5);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (51, N'Joakim', N'Johansson', N'Celsiusg. 9', N'Stockholm', N'Sweden', N'11230', N'+46 08-651 52 52', N'joakim.johansson@yahoo.se', 5);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (52, N'Emma', N'Jones', N'202 Hoxton Street', N'London', N'United Kingdom', N'N1 5LH', N'+44 020 7707 0707', N'emma_jones@hotmail.com', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (53, N'Phil', N'Hughes', N'113 Lupus St', N'London', N'United Kingdom', N'SW1V 3EN', N'+44 020 7976 5722', N'phil.hughes@gmail.com', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (54, N'Steve', N'Murray', N'110 Raeburn Pl', N'Edinburgh ', N'United Kingdom', N'EH4 1HH', N'+44 0131 315 3300', N'steve.murray@yahoo.uk', 5);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "State", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (55, N'Mark', N'Taylor', N'421 Bourke Street', N'Sidney', N'NSW', N'Australia', N'2010', N'+61 (02) 9332 3633', N'mark.taylor@yahoo.au', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (56, N'Diego', N'Gutiérrez', N'307 Macacha Güemes', N'Buenos Aires', N'Argentina', N'1106', N'+54 (0)11 4311 4333', N'diego.gutierrez@yahoo.ar', 4);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "Phone", "Email", "SupportRepId") VALUES (57, N'Luis', N'Rojas', N'Calle Lira, 198', N'Santiago', N'Chile', N'+56 (0)2 635 4444', N'luisrojas@yahoo.cl', 5);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (58, N'Manoj', N'Pareek', N'12,Community Centre', N'Delhi', N'India', N'110017', N'+91 0124 39883988', N'manoj.pareek@rediff.com', 3);
INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Address", "City", "Country", "PostalCode", "Phone", "Email", "SupportRepId") VALUES (59, N'Puja', N'Srivastava', N'3,Raj Bhavan Road', N'Bangalore', N'India', N'560001', N'+91 080 22289999', N'puja_srivastava@yahoo.in', 3);

INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (1, 2, '2009/1/1', N'Theodor-Heuss-Straße 34', N'Stuttgart', N'Germany', N'70174', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (2, 4, '2009/1/2', N'Ullevålsveien 14', N'Oslo', N'Norway', N'0171', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (3, 8, '2009/1/3', N'Grétrystraat 63', N'Brussels', N'Belgium', N'1000', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (4, 14, '2009/1/6', N'8210 111 ST NW', N'Edmonton', N'AB', N'Canada', N'T6G 2C7', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (5, 23, '2009/1/11', N'69 Salem Street', N'Boston', N'MA', N'USA', N'2113', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (6, 37, '2009/1/19', N'Berger Straße 10', N'Frankfurt', N'Germany', N'60316', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (7, 38, '2009/2/1', N'Barbarossastraße 19', N'Berlin', N'Germany', N'10779', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (8, 40, '2009/2/1', N'8, Rue Hanovre', N'Paris', N'France', N'75002', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (9, 42, '2009/2/2', N'9, Place Louis Barthou', N'Bordeaux', N'France', N'33000', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "Total") VALUES (10, 46, '2009/2/3', N'3 Chatham Street', N'Dublin', N'Dublin', N'Ireland', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (11, 52, '2009/2/6', N'202 Hoxton Street', N'London', N'United Kingdom', N'N1 5LH', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (12, 2, '2009/2/11', N'Theodor-Heuss-Straße 34', N'Stuttgart', N'Germany', N'70174', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (13, 16, '2009/2/19', N'1600 Amphitheatre Parkway', N'Mountain View', N'CA', N'USA', N'94043-1351', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (14, 17, '2009/3/4', N'1 Microsoft Way', N'Redmond', N'WA', N'USA', N'98052-8300', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (15, 19, '2009/3/4', N'1 Infinite Loop', N'Cupertino', N'CA', N'USA', N'95014', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (16, 21, '2009/3/5', N'801 W 4th Street', N'Reno', N'NV', N'USA', N'89503', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (17, 25, '2009/3/6', N'319 N. Frances Street', N'Madison', N'WI', N'USA', N'53703', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (18, 31, '2009/3/9', N'194A Chain Lake Drive', N'Halifax', N'NS', N'Canada', N'B3S 1C5', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (19, 40, '2009/3/14', N'8, Rue Hanovre', N'Paris', N'France', N'75002', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (20, 54, '2009/3/22', N'110 Raeburn Pl', N'Edinburgh ', N'United Kingdom', N'EH4 1HH', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (21, 55, '2009/4/4', N'421 Bourke Street', N'Sidney', N'NSW', N'Australia', N'2010', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (22, 57, '2009/4/4', N'Calle Lira, 198', N'Santiago', N'Chile', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (23, 59, '2009/4/5', N'3,Raj Bhavan Road', N'Bangalore', N'India', N'560001', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (24, 4, '2009/4/6', N'Ullevålsveien 14', N'Oslo', N'Norway', N'0171', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (25, 10, '2009/4/9', N'Rua Dr. Falcão Filho, 155', N'São Paulo', N'SP', N'Brazil', N'01007-010', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (26, 19, '2009/4/14', N'1 Infinite Loop', N'Cupertino', N'CA', N'USA', N'95014', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (27, 33, '2009/4/22', N'5112 48 Street', N'Yellowknife', N'NT', N'Canada', N'X1A 1N6', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (28, 34, '2009/5/5', N'Rua da Assunção 53', N'Lisbon', N'Portugal', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (29, 36, '2009/5/5', N'Tauentzienstraße 8', N'Berlin', N'Germany', N'10789', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (30, 38, '2009/5/6', N'Barbarossastraße 19', N'Berlin', N'Germany', N'10779', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (31, 42, '2009/5/7', N'9, Place Louis Barthou', N'Bordeaux', N'France', N'33000', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (32, 48, '2009/5/10', N'Lijnbaansgracht 120bg', N'Amsterdam', N'VV', N'Netherlands', N'1016', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (33, 57, '2009/5/15', N'Calle Lira, 198', N'Santiago', N'Chile', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (34, 12, '2009/5/23', N'Praça Pio X, 119', N'Rio de Janeiro', N'RJ', N'Brazil', N'20040-020', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (35, 13, '2009/6/5', N'Qe 7 Bloco G', N'Brasília', N'DF', N'Brazil', N'71020-677', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (36, 15, '2009/6/5', N'700 W Pender Street', N'Vancouver', N'BC', N'Canada', N'V6C 1G8', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (37, 17, '2009/6/6', N'1 Microsoft Way', N'Redmond', N'WA', N'USA', N'98052-8300', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (38, 21, '2009/6/7', N'801 W 4th Street', N'Reno', N'NV', N'USA', N'89503', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (39, 27, '2009/6/10', N'1033 N Park Ave', N'Tucson', N'AZ', N'USA', N'85719', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (40, 36, '2009/6/15', N'Tauentzienstraße 8', N'Berlin', N'Germany', N'10789', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (41, 50, '2009/6/23', N'C/ San Bernardo 85', N'Madrid', N'Spain', N'28015', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (42, 51, '2009/7/6', N'Celsiusg. 9', N'Stockholm', N'Sweden', N'11230', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (43, 53, '2009/7/6', N'113 Lupus St', N'London', N'United Kingdom', N'SW1V 3EN', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (44, 55, '2009/7/7', N'421 Bourke Street', N'Sidney', N'NSW', N'Australia', N'2010', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (45, 59, '2009/7/8', N'3,Raj Bhavan Road', N'Bangalore', N'India', N'560001', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (46, 6, '2009/7/11', N'Rilská 3174/6', N'Prague', N'Czech Republic', N'14300', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (47, 15, '2009/7/16', N'700 W Pender Street', N'Vancouver', N'BC', N'Canada', N'V6C 1G8', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (48, 29, '2009/7/24', N'796 Dundas Street West', N'Toronto', N'ON', N'Canada', N'M6J 1V1', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (49, 30, '2009/8/6', N'230 Elgin Street', N'Ottawa', N'ON', N'Canada', N'K2P 1L7', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (50, 32, '2009/8/6', N'696 Osborne Street', N'Winnipeg', N'MB', N'Canada', N'R3L 2B9', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (51, 34, '2009/8/7', N'Rua da Assunção 53', N'Lisbon', N'Portugal', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (52, 38, '2009/8/8', N'Barbarossastraße 19', N'Berlin', N'Germany', N'10779', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (53, 44, '2009/8/11', N'Porthaninkatu 9', N'Helsinki', N'Finland', N'00530', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (54, 53, '2009/8/16', N'113 Lupus St', N'London', N'United Kingdom', N'SW1V 3EN', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (55, 8, '2009/8/24', N'Grétrystraat 63', N'Brussels', N'Belgium', N'1000', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (56, 9, '2009/9/6', N'Sønder Boulevard 51', N'Copenhagen', N'Denmark', N'1720', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (57, 11, '2009/9/6', N'Av. Paulista, 2022', N'São Paulo', N'SP', N'Brazil', N'01310-200', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (58, 13, '2009/9/7', N'Qe 7 Bloco G', N'Brasília', N'DF', N'Brazil', N'71020-677', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (59, 17, '2009/9/8', N'1 Microsoft Way', N'Redmond', N'WA', N'USA', N'98052-8300', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (60, 23, '2009/9/11', N'69 Salem Street', N'Boston', N'MA', N'USA', N'2113', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (61, 32, '2009/9/16', N'696 Osborne Street', N'Winnipeg', N'MB', N'Canada', N'R3L 2B9', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "Total") VALUES (62, 46, '2009/9/24', N'3 Chatham Street', N'Dublin', N'Dublin', N'Ireland', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (63, 47, '2009/10/7', N'Via Degli Scipioni, 43', N'Rome', N'RM', N'Italy', N'00192', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (64, 49, '2009/10/7', N'Ordynacka 10', N'Warsaw', N'Poland', N'00-358', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (65, 51, '2009/10/8', N'Celsiusg. 9', N'Stockholm', N'Sweden', N'11230', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (66, 55, '2009/10/9', N'421 Bourke Street', N'Sidney', N'NSW', N'Australia', N'2010', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (67, 2, '2009/10/12', N'Theodor-Heuss-Straße 34', N'Stuttgart', N'Germany', N'70174', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (68, 11, '2009/10/17', N'Av. Paulista, 2022', N'São Paulo', N'SP', N'Brazil', N'01310-200', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (69, 25, '2009/10/25', N'319 N. Frances Street', N'Madison', N'WI', N'USA', N'53703', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (70, 26, '2009/11/7', N'2211 W Berry Street', N'Fort Worth', N'TX', N'USA', N'76110', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (71, 28, '2009/11/7', N'302 S 700 E', N'Salt Lake City', N'UT', N'USA', N'84102', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (72, 30, '2009/11/8', N'230 Elgin Street', N'Ottawa', N'ON', N'Canada', N'K2P 1L7', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (73, 34, '2009/11/9', N'Rua da Assunção 53', N'Lisbon', N'Portugal', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (74, 40, '2009/11/12', N'8, Rue Hanovre', N'Paris', N'France', N'75002', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (75, 49, '2009/11/17', N'Ordynacka 10', N'Warsaw', N'Poland', N'00-358', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (76, 4, '2009/11/25', N'Ullevålsveien 14', N'Oslo', N'Norway', N'0171', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (77, 5, '2009/12/8', N'Klanova 9/506', N'Prague', N'Czech Republic', N'14700', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (78, 7, '2009/12/8', N'Rotenturmstraße 4, 1010 Innere Stadt', N'Vienne', N'Austria', N'1010', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (79, 9, '2009/12/9', N'Sønder Boulevard 51', N'Copenhagen', N'Denmark', N'1720', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (80, 13, '2009/12/10', N'Qe 7 Bloco G', N'Brasília', N'DF', N'Brazil', N'71020-677', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (81, 19, '2009/12/13', N'1 Infinite Loop', N'Cupertino', N'CA', N'USA', N'95014', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (82, 28, '2009/12/18', N'302 S 700 E', N'Salt Lake City', N'UT', N'USA', N'84102', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (83, 42, '2009/12/26', N'9, Place Louis Barthou', N'Bordeaux', N'France', N'33000', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (84, 43, '2010/1/8', N'68, Rue Jouvence', N'Dijon', N'France', N'21000', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (85, 45, '2010/1/8', N'Erzsébet krt. 58.', N'Budapest', N'Hungary', N'H-1073', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (86, 47, '2010/1/9', N'Via Degli Scipioni, 43', N'Rome', N'RM', N'Italy', N'00192', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (87, 51, '2010/1/10', N'Celsiusg. 9', N'Stockholm', N'Sweden', N'11230', 6.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (88, 57, '2010/1/13', N'Calle Lira, 198', N'Santiago', N'Chile', 17.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (89, 7, '2010/1/18', N'Rotenturmstraße 4, 1010 Innere Stadt', N'Vienne', N'Austria', N'1010', 18.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (90, 21, '2010/1/26', N'801 W 4th Street', N'Reno', N'NV', N'USA', N'89503', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (91, 22, '2010/2/8', N'120 S Orange Ave', N'Orlando', N'FL', N'USA', N'32801', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (92, 24, '2010/2/8', N'162 E Superior Street', N'Chicago', N'IL', N'USA', N'60611', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (93, 26, '2010/2/9', N'2211 W Berry Street', N'Fort Worth', N'TX', N'USA', N'76110', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (94, 30, '2010/2/10', N'230 Elgin Street', N'Ottawa', N'ON', N'Canada', N'K2P 1L7', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (95, 36, '2010/2/13', N'Tauentzienstraße 8', N'Berlin', N'Germany', N'10789', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (96, 45, '2010/2/18', N'Erzsébet krt. 58.', N'Budapest', N'Hungary', N'H-1073', 21.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (97, 59, '2010/2/26', N'3,Raj Bhavan Road', N'Bangalore', N'India', N'560001', 1.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (98, 1, '2010/3/11', N'Av. Brigadeiro Faria Lima, 2170', N'São José dos Campos', N'SP', N'Brazil', N'12227-000', 3.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (99, 3, '2010/3/11', N'1498 rue Bélanger', N'Montréal', N'QC', N'Canada', N'H2G 1A7', 3.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (100, 5, '2010/3/12', N'Klanova 9/506', N'Prague', N'Czech Republic', N'14700', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (101, 9, '2010/3/13', N'Sønder Boulevard 51', N'Copenhagen', N'Denmark', N'1720', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (102, 15, '2010/3/16', N'700 W Pender Street', N'Vancouver', N'BC', N'Canada', N'V6C 1G8', 9.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (103, 24, '2010/3/21', N'162 E Superior Street', N'Chicago', N'IL', N'USA', N'60611', 15.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (104, 38, '2010/3/29', N'Barbarossastraße 19', N'Berlin', N'Germany', N'10779', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (105, 39, '2010/4/11', N'4, Rue Milton', N'Paris', N'France', N'75009', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (106, 41, '2010/4/11', N'11, Place Bellecour', N'Lyon', N'France', N'69002', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (107, 43, '2010/4/12', N'68, Rue Jouvence', N'Dijon', N'France', N'21000', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (108, 47, '2010/4/13', N'Via Degli Scipioni, 43', N'Rome', N'RM', N'Italy', N'00192', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (109, 53, '2010/4/16', N'113 Lupus St', N'London', N'United Kingdom', N'SW1V 3EN', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (110, 3, '2010/4/21', N'1498 rue Bélanger', N'Montréal', N'QC', N'Canada', N'H2G 1A7', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (111, 17, '2010/4/29', N'1 Microsoft Way', N'Redmond', N'WA', N'USA', N'98052-8300', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (112, 18, '2010/5/12', N'627 Broadway', N'New York', N'NY', N'USA', N'10012-2612', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (113, 20, '2010/5/12', N'541 Del Medio Avenue', N'Mountain View', N'CA', N'USA', N'94040-111', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (114, 22, '2010/5/13', N'120 S Orange Ave', N'Orlando', N'FL', N'USA', N'32801', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (115, 26, '2010/5/14', N'2211 W Berry Street', N'Fort Worth', N'TX', N'USA', N'76110', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (116, 32, '2010/5/17', N'696 Osborne Street', N'Winnipeg', N'MB', N'Canada', N'R3L 2B9', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (117, 41, '2010/5/22', N'11, Place Bellecour', N'Lyon', N'France', N'69002', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (118, 55, '2010/5/30', N'421 Bourke Street', N'Sidney', N'NSW', N'Australia', N'2010', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (119, 56, '2010/6/12', N'307 Macacha Güemes', N'Buenos Aires', N'Argentina', N'1106', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (120, 58, '2010/6/12', N'12,Community Centre', N'Delhi', N'India', N'110017', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (121, 1, '2010/6/13', N'Av. Brigadeiro Faria Lima, 2170', N'São José dos Campos', N'SP', N'Brazil', N'12227-000', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (122, 5, '2010/6/14', N'Klanova 9/506', N'Prague', N'Czech Republic', N'14700', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (123, 11, '2010/6/17', N'Av. Paulista, 2022', N'São Paulo', N'SP', N'Brazil', N'01310-200', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (124, 20, '2010/6/22', N'541 Del Medio Avenue', N'Mountain View', N'CA', N'USA', N'94040-111', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (125, 34, '2010/6/30', N'Rua da Assunção 53', N'Lisbon', N'Portugal', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (126, 35, '2010/7/13', N'Rua dos Campeões Europeus de Viena, 4350', N'Porto', N'Portugal', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (127, 37, '2010/7/13', N'Berger Straße 10', N'Frankfurt', N'Germany', N'60316', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (128, 39, '2010/7/14', N'4, Rue Milton', N'Paris', N'France', N'75009', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (129, 43, '2010/7/15', N'68, Rue Jouvence', N'Dijon', N'France', N'21000', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (130, 49, '2010/7/18', N'Ordynacka 10', N'Warsaw', N'Poland', N'00-358', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (131, 58, '2010/7/23', N'12,Community Centre', N'Delhi', N'India', N'110017', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (132, 13, '2010/7/31', N'Qe 7 Bloco G', N'Brasília', N'DF', N'Brazil', N'71020-677', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (133, 14, '2010/8/13', N'8210 111 ST NW', N'Edmonton', N'AB', N'Canada', N'T6G 2C7', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (134, 16, '2010/8/13', N'1600 Amphitheatre Parkway', N'Mountain View', N'CA', N'USA', N'94043-1351', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (135, 18, '2010/8/14', N'627 Broadway', N'New York', N'NY', N'USA', N'10012-2612', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (136, 22, '2010/8/15', N'120 S Orange Ave', N'Orlando', N'FL', N'USA', N'32801', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (137, 28, '2010/8/18', N'302 S 700 E', N'Salt Lake City', N'UT', N'USA', N'84102', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (138, 37, '2010/8/23', N'Berger Straße 10', N'Frankfurt', N'Germany', N'60316', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (139, 51, '2010/8/31', N'Celsiusg. 9', N'Stockholm', N'Sweden', N'11230', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (140, 52, '2010/9/13', N'202 Hoxton Street', N'London', N'United Kingdom', N'N1 5LH', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (141, 54, '2010/9/13', N'110 Raeburn Pl', N'Edinburgh ', N'United Kingdom', N'EH4 1HH', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (142, 56, '2010/9/14', N'307 Macacha Güemes', N'Buenos Aires', N'Argentina', N'1106', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (143, 1, '2010/9/15', N'Av. Brigadeiro Faria Lima, 2170', N'São José dos Campos', N'SP', N'Brazil', N'12227-000', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (144, 7, '2010/9/18', N'Rotenturmstraße 4, 1010 Innere Stadt', N'Vienne', N'Austria', N'1010', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (145, 16, '2010/9/23', N'1600 Amphitheatre Parkway', N'Mountain View', N'CA', N'USA', N'94043-1351', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (146, 30, '2010/10/1', N'230 Elgin Street', N'Ottawa', N'ON', N'Canada', N'K2P 1L7', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (147, 31, '2010/10/14', N'194A Chain Lake Drive', N'Halifax', N'NS', N'Canada', N'B3S 1C5', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (148, 33, '2010/10/14', N'5112 48 Street', N'Yellowknife', N'NT', N'Canada', N'X1A 1N6', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (149, 35, '2010/10/15', N'Rua dos Campeões Europeus de Viena, 4350', N'Porto', N'Portugal', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (150, 39, '2010/10/16', N'4, Rue Milton', N'Paris', N'France', N'75009', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (151, 45, '2010/10/19', N'Erzsébet krt. 58.', N'Budapest', N'Hungary', N'H-1073', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (152, 54, '2010/10/24', N'110 Raeburn Pl', N'Edinburgh ', N'United Kingdom', N'EH4 1HH', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (153, 9, '2010/11/1', N'Sønder Boulevard 51', N'Copenhagen', N'Denmark', N'1720', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (154, 10, '2010/11/14', N'Rua Dr. Falcão Filho, 155', N'São Paulo', N'SP', N'Brazil', N'01007-010', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (155, 12, '2010/11/14', N'Praça Pio X, 119', N'Rio de Janeiro', N'RJ', N'Brazil', N'20040-020', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (156, 14, '2010/11/15', N'8210 111 ST NW', N'Edmonton', N'AB', N'Canada', N'T6G 2C7', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (157, 18, '2010/11/16', N'627 Broadway', N'New York', N'NY', N'USA', N'10012-2612', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (158, 24, '2010/11/19', N'162 E Superior Street', N'Chicago', N'IL', N'USA', N'60611', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (159, 33, '2010/11/24', N'5112 48 Street', N'Yellowknife', N'NT', N'Canada', N'X1A 1N6', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (160, 47, '2010/12/2', N'Via Degli Scipioni, 43', N'Rome', N'RM', N'Italy', N'00192', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (161, 48, '2010/12/15', N'Lijnbaansgracht 120bg', N'Amsterdam', N'VV', N'Netherlands', N'1016', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (162, 50, '2010/12/15', N'C/ San Bernardo 85', N'Madrid', N'Spain', N'28015', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (163, 52, '2010/12/16', N'202 Hoxton Street', N'London', N'United Kingdom', N'N1 5LH', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (164, 56, '2010/12/17', N'307 Macacha Güemes', N'Buenos Aires', N'Argentina', N'1106', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (165, 3, '2010/12/20', N'1498 rue Bélanger', N'Montréal', N'QC', N'Canada', N'H2G 1A7', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (166, 12, '2010/12/25', N'Praça Pio X, 119', N'Rio de Janeiro', N'RJ', N'Brazil', N'20040-020', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (167, 26, '2011/1/2', N'2211 W Berry Street', N'Fort Worth', N'TX', N'USA', N'76110', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (168, 27, '2011/1/15', N'1033 N Park Ave', N'Tucson', N'AZ', N'USA', N'85719', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (169, 29, '2011/1/15', N'796 Dundas Street West', N'Toronto', N'ON', N'Canada', N'M6J 1V1', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (170, 31, '2011/1/16', N'194A Chain Lake Drive', N'Halifax', N'NS', N'Canada', N'B3S 1C5', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (171, 35, '2011/1/17', N'Rua dos Campeões Europeus de Viena, 4350', N'Porto', N'Portugal', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (172, 41, '2011/1/20', N'11, Place Bellecour', N'Lyon', N'France', N'69002', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (173, 50, '2011/1/25', N'C/ San Bernardo 85', N'Madrid', N'Spain', N'28015', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (174, 5, '2011/2/2', N'Klanova 9/506', N'Prague', N'Czech Republic', N'14700', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (175, 6, '2011/2/15', N'Rilská 3174/6', N'Prague', N'Czech Republic', N'14300', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (176, 8, '2011/2/15', N'Grétrystraat 63', N'Brussels', N'Belgium', N'1000', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (177, 10, '2011/2/16', N'Rua Dr. Falcão Filho, 155', N'São Paulo', N'SP', N'Brazil', N'01007-010', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (178, 14, '2011/2/17', N'8210 111 ST NW', N'Edmonton', N'AB', N'Canada', N'T6G 2C7', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (179, 20, '2011/2/20', N'541 Del Medio Avenue', N'Mountain View', N'CA', N'USA', N'94040-111', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (180, 29, '2011/2/25', N'796 Dundas Street West', N'Toronto', N'ON', N'Canada', N'M6J 1V1', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (181, 43, '2011/3/5', N'68, Rue Jouvence', N'Dijon', N'France', N'21000', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (182, 44, '2011/3/18', N'Porthaninkatu 9', N'Helsinki', N'Finland', N'00530', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "Total") VALUES (183, 46, '2011/3/18', N'3 Chatham Street', N'Dublin', N'Dublin', N'Ireland', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (184, 48, '2011/3/19', N'Lijnbaansgracht 120bg', N'Amsterdam', N'VV', N'Netherlands', N'1016', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (185, 52, '2011/3/20', N'202 Hoxton Street', N'London', N'United Kingdom', N'N1 5LH', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (186, 58, '2011/3/23', N'12,Community Centre', N'Delhi', N'India', N'110017', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (187, 8, '2011/3/28', N'Grétrystraat 63', N'Brussels', N'Belgium', N'1000', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (188, 22, '2011/4/5', N'120 S Orange Ave', N'Orlando', N'FL', N'USA', N'32801', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (189, 23, '2011/4/18', N'69 Salem Street', N'Boston', N'MA', N'USA', N'2113', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (190, 25, '2011/4/18', N'319 N. Frances Street', N'Madison', N'WI', N'USA', N'53703', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (191, 27, '2011/4/19', N'1033 N Park Ave', N'Tucson', N'AZ', N'USA', N'85719', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (192, 31, '2011/4/20', N'194A Chain Lake Drive', N'Halifax', N'NS', N'Canada', N'B3S 1C5', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (193, 37, '2011/4/23', N'Berger Straße 10', N'Frankfurt', N'Germany', N'60316', 14.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "Total") VALUES (194, 46, '2011/4/28', N'3 Chatham Street', N'Dublin', N'Dublin', N'Ireland', 21.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (195, 1, '2011/5/6', N'Av. Brigadeiro Faria Lima, 2170', N'São José dos Campos', N'SP', N'Brazil', N'12227-000', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (196, 2, '2011/5/19', N'Theodor-Heuss-Straße 34', N'Stuttgart', N'Germany', N'70174', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (197, 4, '2011/5/19', N'Ullevålsveien 14', N'Oslo', N'Norway', N'0171', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (198, 6, '2011/5/20', N'Rilská 3174/6', N'Prague', N'Czech Republic', N'14300', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (199, 10, '2011/5/21', N'Rua Dr. Falcão Filho, 155', N'São Paulo', N'SP', N'Brazil', N'01007-010', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (200, 16, '2011/5/24', N'1600 Amphitheatre Parkway', N'Mountain View', N'CA', N'USA', N'94043-1351', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (201, 25, '2011/5/29', N'319 N. Frances Street', N'Madison', N'WI', N'USA', N'53703', 18.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (202, 39, '2011/6/6', N'4, Rue Milton', N'Paris', N'France', N'75009', 1.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (203, 40, '2011/6/19', N'8, Rue Hanovre', N'Paris', N'France', N'75002', 2.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (204, 42, '2011/6/19', N'9, Place Louis Barthou', N'Bordeaux', N'France', N'33000', 3.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (205, 44, '2011/6/20', N'Porthaninkatu 9', N'Helsinki', N'Finland', N'00530', 7.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (206, 48, '2011/6/21', N'Lijnbaansgracht 120bg', N'Amsterdam', N'VV', N'Netherlands', N'1016', 8.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (207, 54, '2011/6/24', N'110 Raeburn Pl', N'Edinburgh ', N'United Kingdom', N'EH4 1HH', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (208, 4, '2011/6/29', N'Ullevålsveien 14', N'Oslo', N'Norway', N'0171', 15.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (209, 18, '2011/7/7', N'627 Broadway', N'New York', N'NY', N'USA', N'10012-2612', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (210, 19, '2011/7/20', N'1 Infinite Loop', N'Cupertino', N'CA', N'USA', N'95014', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (211, 21, '2011/7/20', N'801 W 4th Street', N'Reno', N'NV', N'USA', N'89503', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (212, 23, '2011/7/21', N'69 Salem Street', N'Boston', N'MA', N'USA', N'2113', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (213, 27, '2011/7/22', N'1033 N Park Ave', N'Tucson', N'AZ', N'USA', N'85719', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (214, 33, '2011/7/25', N'5112 48 Street', N'Yellowknife', N'NT', N'Canada', N'X1A 1N6', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (215, 42, '2011/7/30', N'9, Place Louis Barthou', N'Bordeaux', N'France', N'33000', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (216, 56, '2011/8/7', N'307 Macacha Güemes', N'Buenos Aires', N'Argentina', N'1106', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (217, 57, '2011/8/20', N'Calle Lira, 198', N'Santiago', N'Chile', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (218, 59, '2011/8/20', N'3,Raj Bhavan Road', N'Bangalore', N'India', N'560001', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (219, 2, '2011/8/21', N'Theodor-Heuss-Straße 34', N'Stuttgart', N'Germany', N'70174', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (220, 6, '2011/8/22', N'Rilská 3174/6', N'Prague', N'Czech Republic', N'14300', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (221, 12, '2011/8/25', N'Praça Pio X, 119', N'Rio de Janeiro', N'RJ', N'Brazil', N'20040-020', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (222, 21, '2011/8/30', N'801 W 4th Street', N'Reno', N'NV', N'USA', N'89503', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (223, 35, '2011/9/7', N'Rua dos Campeões Europeus de Viena, 4350', N'Porto', N'Portugal', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (224, 36, '2011/9/20', N'Tauentzienstraße 8', N'Berlin', N'Germany', N'10789', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (225, 38, '2011/9/20', N'Barbarossastraße 19', N'Berlin', N'Germany', N'10779', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (226, 40, '2011/9/21', N'8, Rue Hanovre', N'Paris', N'France', N'75002', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (227, 44, '2011/9/22', N'Porthaninkatu 9', N'Helsinki', N'Finland', N'00530', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (228, 50, '2011/9/25', N'C/ San Bernardo 85', N'Madrid', N'Spain', N'28015', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (229, 59, '2011/9/30', N'3,Raj Bhavan Road', N'Bangalore', N'India', N'560001', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (230, 14, '2011/10/8', N'8210 111 ST NW', N'Edmonton', N'AB', N'Canada', N'T6G 2C7', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (231, 15, '2011/10/21', N'700 W Pender Street', N'Vancouver', N'BC', N'Canada', N'V6C 1G8', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (232, 17, '2011/10/21', N'1 Microsoft Way', N'Redmond', N'WA', N'USA', N'98052-8300', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (233, 19, '2011/10/22', N'1 Infinite Loop', N'Cupertino', N'CA', N'USA', N'95014', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (234, 23, '2011/10/23', N'69 Salem Street', N'Boston', N'MA', N'USA', N'2113', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (235, 29, '2011/10/26', N'796 Dundas Street West', N'Toronto', N'ON', N'Canada', N'M6J 1V1', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (236, 38, '2011/10/31', N'Barbarossastraße 19', N'Berlin', N'Germany', N'10779', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (237, 52, '2011/11/8', N'202 Hoxton Street', N'London', N'United Kingdom', N'N1 5LH', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (238, 53, '2011/11/21', N'113 Lupus St', N'London', N'United Kingdom', N'SW1V 3EN', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (239, 55, '2011/11/21', N'421 Bourke Street', N'Sidney', N'NSW', N'Australia', N'2010', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (240, 57, '2011/11/22', N'Calle Lira, 198', N'Santiago', N'Chile', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (241, 2, '2011/11/23', N'Theodor-Heuss-Straße 34', N'Stuttgart', N'Germany', N'70174', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (242, 8, '2011/11/26', N'Grétrystraat 63', N'Brussels', N'Belgium', N'1000', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (243, 17, '2011/12/1', N'1 Microsoft Way', N'Redmond', N'WA', N'USA', N'98052-8300', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (244, 31, '2011/12/9', N'194A Chain Lake Drive', N'Halifax', N'NS', N'Canada', N'B3S 1C5', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (245, 32, '2011/12/22', N'696 Osborne Street', N'Winnipeg', N'MB', N'Canada', N'R3L 2B9', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (246, 34, '2011/12/22', N'Rua da Assunção 53', N'Lisbon', N'Portugal', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (247, 36, '2011/12/23', N'Tauentzienstraße 8', N'Berlin', N'Germany', N'10789', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (248, 40, '2011/12/24', N'8, Rue Hanovre', N'Paris', N'France', N'75002', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "Total") VALUES (249, 46, '2011/12/27', N'3 Chatham Street', N'Dublin', N'Dublin', N'Ireland', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (250, 55, '2012/1/1', N'421 Bourke Street', N'Sidney', N'NSW', N'Australia', N'2010', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (251, 10, '2012/1/9', N'Rua Dr. Falcão Filho, 155', N'São Paulo', N'SP', N'Brazil', N'01007-010', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (252, 11, '2012/1/22', N'Av. Paulista, 2022', N'São Paulo', N'SP', N'Brazil', N'01310-200', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (253, 13, '2012/1/22', N'Qe 7 Bloco G', N'Brasília', N'DF', N'Brazil', N'71020-677', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (254, 15, '2012/1/23', N'700 W Pender Street', N'Vancouver', N'BC', N'Canada', N'V6C 1G8', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (255, 19, '2012/1/24', N'1 Infinite Loop', N'Cupertino', N'CA', N'USA', N'95014', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (256, 25, '2012/1/27', N'319 N. Frances Street', N'Madison', N'WI', N'USA', N'53703', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (257, 34, '2012/2/1', N'Rua da Assunção 53', N'Lisbon', N'Portugal', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (258, 48, '2012/2/9', N'Lijnbaansgracht 120bg', N'Amsterdam', N'VV', N'Netherlands', N'1016', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (259, 49, '2012/2/22', N'Ordynacka 10', N'Warsaw', N'Poland', N'00-358', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (260, 51, '2012/2/22', N'Celsiusg. 9', N'Stockholm', N'Sweden', N'11230', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (261, 53, '2012/2/23', N'113 Lupus St', N'London', N'United Kingdom', N'SW1V 3EN', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (262, 57, '2012/2/24', N'Calle Lira, 198', N'Santiago', N'Chile', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (263, 4, '2012/2/27', N'Ullevålsveien 14', N'Oslo', N'Norway', N'0171', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (264, 13, '2012/3/3', N'Qe 7 Bloco G', N'Brasília', N'DF', N'Brazil', N'71020-677', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (265, 27, '2012/3/11', N'1033 N Park Ave', N'Tucson', N'AZ', N'USA', N'85719', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (266, 28, '2012/3/24', N'302 S 700 E', N'Salt Lake City', N'UT', N'USA', N'84102', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (267, 30, '2012/3/24', N'230 Elgin Street', N'Ottawa', N'ON', N'Canada', N'K2P 1L7', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (268, 32, '2012/3/25', N'696 Osborne Street', N'Winnipeg', N'MB', N'Canada', N'R3L 2B9', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (269, 36, '2012/3/26', N'Tauentzienstraße 8', N'Berlin', N'Germany', N'10789', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (270, 42, '2012/3/29', N'9, Place Louis Barthou', N'Bordeaux', N'France', N'33000', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (271, 51, '2012/4/3', N'Celsiusg. 9', N'Stockholm', N'Sweden', N'11230', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (272, 6, '2012/4/11', N'Rilská 3174/6', N'Prague', N'Czech Republic', N'14300', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (273, 7, '2012/4/24', N'Rotenturmstraße 4, 1010 Innere Stadt', N'Vienne', N'Austria', N'1010', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (274, 9, '2012/4/24', N'Sønder Boulevard 51', N'Copenhagen', N'Denmark', N'1720', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (275, 11, '2012/4/25', N'Av. Paulista, 2022', N'São Paulo', N'SP', N'Brazil', N'01310-200', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (276, 15, '2012/4/26', N'700 W Pender Street', N'Vancouver', N'BC', N'Canada', N'V6C 1G8', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (277, 21, '2012/4/29', N'801 W 4th Street', N'Reno', N'NV', N'USA', N'89503', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (278, 30, '2012/5/4', N'230 Elgin Street', N'Ottawa', N'ON', N'Canada', N'K2P 1L7', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (279, 44, '2012/5/12', N'Porthaninkatu 9', N'Helsinki', N'Finland', N'00530', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (280, 45, '2012/5/25', N'Erzsébet krt. 58.', N'Budapest', N'Hungary', N'H-1073', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (281, 47, '2012/5/25', N'Via Degli Scipioni, 43', N'Rome', N'RM', N'Italy', N'00192', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (282, 49, '2012/5/26', N'Ordynacka 10', N'Warsaw', N'Poland', N'00-358', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (283, 53, '2012/5/27', N'113 Lupus St', N'London', N'United Kingdom', N'SW1V 3EN', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (284, 59, '2012/5/30', N'3,Raj Bhavan Road', N'Bangalore', N'India', N'560001', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (285, 9, '2012/6/4', N'Sønder Boulevard 51', N'Copenhagen', N'Denmark', N'1720', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (286, 23, '2012/6/12', N'69 Salem Street', N'Boston', N'MA', N'USA', N'2113', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (287, 24, '2012/6/25', N'162 E Superior Street', N'Chicago', N'IL', N'USA', N'60611', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (288, 26, '2012/6/25', N'2211 W Berry Street', N'Fort Worth', N'TX', N'USA', N'76110', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (289, 28, '2012/6/26', N'302 S 700 E', N'Salt Lake City', N'UT', N'USA', N'84102', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (290, 32, '2012/6/27', N'696 Osborne Street', N'Winnipeg', N'MB', N'Canada', N'R3L 2B9', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (291, 38, '2012/6/30', N'Barbarossastraße 19', N'Berlin', N'Germany', N'10779', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (292, 47, '2012/7/5', N'Via Degli Scipioni, 43', N'Rome', N'RM', N'Italy', N'00192', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (293, 2, '2012/7/13', N'Theodor-Heuss-Straße 34', N'Stuttgart', N'Germany', N'70174', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (294, 3, '2012/7/26', N'1498 rue Bélanger', N'Montréal', N'QC', N'Canada', N'H2G 1A7', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (295, 5, '2012/7/26', N'Klanova 9/506', N'Prague', N'Czech Republic', N'14700', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (296, 7, '2012/7/27', N'Rotenturmstraße 4, 1010 Innere Stadt', N'Vienne', N'Austria', N'1010', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (297, 11, '2012/7/28', N'Av. Paulista, 2022', N'São Paulo', N'SP', N'Brazil', N'01310-200', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (298, 17, '2012/7/31', N'1 Microsoft Way', N'Redmond', N'WA', N'USA', N'98052-8300', 10.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (299, 26, '2012/8/5', N'2211 W Berry Street', N'Fort Worth', N'TX', N'USA', N'76110', 23.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (300, 40, '2012/8/13', N'8, Rue Hanovre', N'Paris', N'France', N'75002', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (301, 41, '2012/8/26', N'11, Place Bellecour', N'Lyon', N'France', N'69002', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (302, 43, '2012/8/26', N'68, Rue Jouvence', N'Dijon', N'France', N'21000', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (303, 45, '2012/8/27', N'Erzsébet krt. 58.', N'Budapest', N'Hungary', N'H-1073', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (304, 49, '2012/8/28', N'Ordynacka 10', N'Warsaw', N'Poland', N'00-358', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (305, 55, '2012/8/31', N'421 Bourke Street', N'Sidney', N'NSW', N'Australia', N'2010', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (306, 5, '2012/9/5', N'Klanova 9/506', N'Prague', N'Czech Republic', N'14700', 16.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (307, 19, '2012/9/13', N'1 Infinite Loop', N'Cupertino', N'CA', N'USA', N'95014', 1.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (308, 20, '2012/9/26', N'541 Del Medio Avenue', N'Mountain View', N'CA', N'USA', N'94040-111', 3.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (309, 22, '2012/9/26', N'120 S Orange Ave', N'Orlando', N'FL', N'USA', N'32801', 3.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (310, 24, '2012/9/27', N'162 E Superior Street', N'Chicago', N'IL', N'USA', N'60611', 7.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (311, 28, '2012/9/28', N'302 S 700 E', N'Salt Lake City', N'UT', N'USA', N'84102', 11.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (312, 34, '2012/10/1', N'Rua da Assunção 53', N'Lisbon', N'Portugal', 10.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (313, 43, '2012/10/6', N'68, Rue Jouvence', N'Dijon', N'France', N'21000', 16.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (314, 57, '2012/10/14', N'Calle Lira, 198', N'Santiago', N'Chile', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (315, 58, '2012/10/27', N'12,Community Centre', N'Delhi', N'India', N'110017', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (316, 1, '2012/10/27', N'Av. Brigadeiro Faria Lima, 2170', N'São José dos Campos', N'SP', N'Brazil', N'12227-000', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (317, 3, '2012/10/28', N'1498 rue Bélanger', N'Montréal', N'QC', N'Canada', N'H2G 1A7', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (318, 7, '2012/10/29', N'Rotenturmstraße 4, 1010 Innere Stadt', N'Vienne', N'Austria', N'1010', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (319, 13, '2012/11/1', N'Qe 7 Bloco G', N'Brasília', N'DF', N'Brazil', N'71020-677', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (320, 22, '2012/11/6', N'120 S Orange Ave', N'Orlando', N'FL', N'USA', N'32801', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (321, 36, '2012/11/14', N'Tauentzienstraße 8', N'Berlin', N'Germany', N'10789', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (322, 37, '2012/11/27', N'Berger Straße 10', N'Frankfurt', N'Germany', N'60316', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (323, 39, '2012/11/27', N'4, Rue Milton', N'Paris', N'France', N'75009', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (324, 41, '2012/11/28', N'11, Place Bellecour', N'Lyon', N'France', N'69002', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (325, 45, '2012/11/29', N'Erzsébet krt. 58.', N'Budapest', N'Hungary', N'H-1073', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (326, 51, '2012/12/2', N'Celsiusg. 9', N'Stockholm', N'Sweden', N'11230', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (327, 1, '2012/12/7', N'Av. Brigadeiro Faria Lima, 2170', N'São José dos Campos', N'SP', N'Brazil', N'12227-000', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (328, 15, '2012/12/15', N'700 W Pender Street', N'Vancouver', N'BC', N'Canada', N'V6C 1G8', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (329, 16, '2012/12/28', N'1600 Amphitheatre Parkway', N'Mountain View', N'CA', N'USA', N'94043-1351', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (330, 18, '2012/12/28', N'627 Broadway', N'New York', N'NY', N'USA', N'10012-2612', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (331, 20, '2012/12/29', N'541 Del Medio Avenue', N'Mountain View', N'CA', N'USA', N'94040-111', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (332, 24, '2012/12/30', N'162 E Superior Street', N'Chicago', N'IL', N'USA', N'60611', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (333, 30, '2013/1/2', N'230 Elgin Street', N'Ottawa', N'ON', N'Canada', N'K2P 1L7', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (334, 39, '2013/1/7', N'4, Rue Milton', N'Paris', N'France', N'75009', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (335, 53, '2013/1/15', N'113 Lupus St', N'London', N'United Kingdom', N'SW1V 3EN', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (336, 54, '2013/1/28', N'110 Raeburn Pl', N'Edinburgh ', N'United Kingdom', N'EH4 1HH', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (337, 56, '2013/1/28', N'307 Macacha Güemes', N'Buenos Aires', N'Argentina', N'1106', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (338, 58, '2013/1/29', N'12,Community Centre', N'Delhi', N'India', N'110017', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (339, 3, '2013/1/30', N'1498 rue Bélanger', N'Montréal', N'QC', N'Canada', N'H2G 1A7', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (340, 9, '2013/2/2', N'Sønder Boulevard 51', N'Copenhagen', N'Denmark', N'1720', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (341, 18, '2013/2/7', N'627 Broadway', N'New York', N'NY', N'USA', N'10012-2612', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (342, 32, '2013/2/15', N'696 Osborne Street', N'Winnipeg', N'MB', N'Canada', N'R3L 2B9', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (343, 33, '2013/2/28', N'5112 48 Street', N'Yellowknife', N'NT', N'Canada', N'X1A 1N6', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (344, 35, '2013/2/28', N'Rua dos Campeões Europeus de Viena, 4350', N'Porto', N'Portugal', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (345, 37, '2013/3/1', N'Berger Straße 10', N'Frankfurt', N'Germany', N'60316', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (346, 41, '2013/3/2', N'11, Place Bellecour', N'Lyon', N'France', N'69002', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (347, 47, '2013/3/5', N'Via Degli Scipioni, 43', N'Rome', N'RM', N'Italy', N'00192', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (348, 56, '2013/3/10', N'307 Macacha Güemes', N'Buenos Aires', N'Argentina', N'1106', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (349, 11, '2013/3/18', N'Av. Paulista, 2022', N'São Paulo', N'SP', N'Brazil', N'01310-200', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (350, 12, '2013/3/31', N'Praça Pio X, 119', N'Rio de Janeiro', N'RJ', N'Brazil', N'20040-020', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (351, 14, '2013/3/31', N'8210 111 ST NW', N'Edmonton', N'AB', N'Canada', N'T6G 2C7', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (352, 16, '2013/4/1', N'1600 Amphitheatre Parkway', N'Mountain View', N'CA', N'USA', N'94043-1351', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (353, 20, '2013/4/2', N'541 Del Medio Avenue', N'Mountain View', N'CA', N'USA', N'94040-111', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (354, 26, '2013/4/5', N'2211 W Berry Street', N'Fort Worth', N'TX', N'USA', N'76110', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (355, 35, '2013/4/10', N'Rua dos Campeões Europeus de Viena, 4350', N'Porto', N'Portugal', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (356, 49, '2013/4/18', N'Ordynacka 10', N'Warsaw', N'Poland', N'00-358', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (357, 50, '2013/5/1', N'C/ San Bernardo 85', N'Madrid', N'Spain', N'28015', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (358, 52, '2013/5/1', N'202 Hoxton Street', N'London', N'United Kingdom', N'N1 5LH', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (359, 54, '2013/5/2', N'110 Raeburn Pl', N'Edinburgh ', N'United Kingdom', N'EH4 1HH', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (360, 58, '2013/5/3', N'12,Community Centre', N'Delhi', N'India', N'110017', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (361, 5, '2013/5/6', N'Klanova 9/506', N'Prague', N'Czech Republic', N'14700', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (362, 14, '2013/5/11', N'8210 111 ST NW', N'Edmonton', N'AB', N'Canada', N'T6G 2C7', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (363, 28, '2013/5/19', N'302 S 700 E', N'Salt Lake City', N'UT', N'USA', N'84102', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (364, 29, '2013/6/1', N'796 Dundas Street West', N'Toronto', N'ON', N'Canada', N'M6J 1V1', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (365, 31, '2013/6/1', N'194A Chain Lake Drive', N'Halifax', N'NS', N'Canada', N'B3S 1C5', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (366, 33, '2013/6/2', N'5112 48 Street', N'Yellowknife', N'NT', N'Canada', N'X1A 1N6', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (367, 37, '2013/6/3', N'Berger Straße 10', N'Frankfurt', N'Germany', N'60316', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (368, 43, '2013/6/6', N'68, Rue Jouvence', N'Dijon', N'France', N'21000', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (369, 52, '2013/6/11', N'202 Hoxton Street', N'London', N'United Kingdom', N'N1 5LH', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (370, 7, '2013/6/19', N'Rotenturmstraße 4, 1010 Innere Stadt', N'Vienne', N'Austria', N'1010', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (371, 8, '2013/7/2', N'Grétrystraat 63', N'Brussels', N'Belgium', N'1000', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (372, 10, '2013/7/2', N'Rua Dr. Falcão Filho, 155', N'São Paulo', N'SP', N'Brazil', N'01007-010', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (373, 12, '2013/7/3', N'Praça Pio X, 119', N'Rio de Janeiro', N'RJ', N'Brazil', N'20040-020', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (374, 16, '2013/7/4', N'1600 Amphitheatre Parkway', N'Mountain View', N'CA', N'USA', N'94043-1351', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (375, 22, '2013/7/7', N'120 S Orange Ave', N'Orlando', N'FL', N'USA', N'32801', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (376, 31, '2013/7/12', N'194A Chain Lake Drive', N'Halifax', N'NS', N'Canada', N'B3S 1C5', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (377, 45, '2013/7/20', N'Erzsébet krt. 58.', N'Budapest', N'Hungary', N'H-1073', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "Total") VALUES (378, 46, '2013/8/2', N'3 Chatham Street', N'Dublin', N'Dublin', N'Ireland', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (379, 48, '2013/8/2', N'Lijnbaansgracht 120bg', N'Amsterdam', N'VV', N'Netherlands', N'1016', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (380, 50, '2013/8/3', N'C/ San Bernardo 85', N'Madrid', N'Spain', N'28015', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (381, 54, '2013/8/4', N'110 Raeburn Pl', N'Edinburgh ', N'United Kingdom', N'EH4 1HH', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (382, 1, '2013/8/7', N'Av. Brigadeiro Faria Lima, 2170', N'São José dos Campos', N'SP', N'Brazil', N'12227-000', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (383, 10, '2013/8/12', N'Rua Dr. Falcão Filho, 155', N'São Paulo', N'SP', N'Brazil', N'01007-010', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (384, 24, '2013/8/20', N'162 E Superior Street', N'Chicago', N'IL', N'USA', N'60611', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (385, 25, '2013/9/2', N'319 N. Frances Street', N'Madison', N'WI', N'USA', N'53703', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (386, 27, '2013/9/2', N'1033 N Park Ave', N'Tucson', N'AZ', N'USA', N'85719', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (387, 29, '2013/9/3', N'796 Dundas Street West', N'Toronto', N'ON', N'Canada', N'M6J 1V1', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (388, 33, '2013/9/4', N'5112 48 Street', N'Yellowknife', N'NT', N'Canada', N'X1A 1N6', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (389, 39, '2013/9/7', N'4, Rue Milton', N'Paris', N'France', N'75009', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (390, 48, '2013/9/12', N'Lijnbaansgracht 120bg', N'Amsterdam', N'VV', N'Netherlands', N'1016', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (391, 3, '2013/9/20', N'1498 rue Bélanger', N'Montréal', N'QC', N'Canada', N'H2G 1A7', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (392, 4, '2013/10/3', N'Ullevålsveien 14', N'Oslo', N'Norway', N'0171', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (393, 6, '2013/10/3', N'Rilská 3174/6', N'Prague', N'Czech Republic', N'14300', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (394, 8, '2013/10/4', N'Grétrystraat 63', N'Brussels', N'Belgium', N'1000', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (395, 12, '2013/10/5', N'Praça Pio X, 119', N'Rio de Janeiro', N'RJ', N'Brazil', N'20040-020', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (396, 18, '2013/10/8', N'627 Broadway', N'New York', N'NY', N'USA', N'10012-2612', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (397, 27, '2013/10/13', N'1033 N Park Ave', N'Tucson', N'AZ', N'USA', N'85719', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (398, 41, '2013/10/21', N'11, Place Bellecour', N'Lyon', N'France', N'69002', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (399, 42, '2013/11/3', N'9, Place Louis Barthou', N'Bordeaux', N'France', N'33000', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (400, 44, '2013/11/3', N'Porthaninkatu 9', N'Helsinki', N'Finland', N'00530', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "Total") VALUES (401, 46, '2013/11/4', N'3 Chatham Street', N'Dublin', N'Dublin', N'Ireland', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (402, 50, '2013/11/5', N'C/ San Bernardo 85', N'Madrid', N'Spain', N'28015', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (403, 56, '2013/11/8', N'307 Macacha Güemes', N'Buenos Aires', N'Argentina', N'1106', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (404, 6, '2013/11/13', N'Rilská 3174/6', N'Prague', N'Czech Republic', N'14300', 25.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (405, 20, '2013/11/21', N'541 Del Medio Avenue', N'Mountain View', N'CA', N'USA', N'94040-111', 0.99);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (406, 21, '2013/12/4', N'801 W 4th Street', N'Reno', N'NV', N'USA', N'89503', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (407, 23, '2013/12/4', N'69 Salem Street', N'Boston', N'MA', N'USA', N'2113', 1.98);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (408, 25, '2013/12/5', N'319 N. Frances Street', N'Madison', N'WI', N'USA', N'53703', 3.96);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingState", "BillingCountry", "BillingPostalCode", "Total") VALUES (409, 29, '2013/12/6', N'796 Dundas Street West', N'Toronto', N'ON', N'Canada', N'M6J 1V1', 5.94);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "Total") VALUES (410, 35, '2013/12/9', N'Rua dos Campeões Europeus de Viena, 4350', N'Porto', N'Portugal', 8.91);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (411, 44, '2013/12/14', N'Porthaninkatu 9', N'Helsinki', N'Finland', N'00530', 13.86);
INSERT INTO "Invoice" ("InvoiceId", "CustomerId", "InvoiceDate", "BillingAddress", "BillingCity", "BillingCountry", "BillingPostalCode", "Total") VALUES (412, 58, '2013/12/22', N'12,Community Centre', N'Delhi', N'India', N'110017', 1.99);

SELECT *
FROM "Customer"

SELECT *
FROM "Invoice"
-- TODO 
-- TODO
-- Co ak chcem najst meno a priezvisko zakaznika co zaplatil najvacsi ucet + cena uctu?
SELECT "FirstName", "LastName", "Total"
FROM "Invoice"
JOIN "Customer"
	ON "Invoice"."CustomerId" = "Customer"."CustomerId"
ORDER BY "Invoice"."Total" DESC


-- suhrn kolo zaplatili fran a heleny
SELECT SUM("Total")
--SELECT "FirstName"
FROM "Invoice"
JOIN "Customer"
	ON "Invoice"."CustomerId" = "Customer"."CustomerId"
WHERE
-- "Invoice"."BillingCountry" = 'France'
 "Customer"."FirstName" = 'Helena'

    

DROP TABLE IF EXISTS "Customer" CASCADE;
DROP TABLE IF EXISTS "Invoice" CASCADE;
















