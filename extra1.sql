CREATE TABLE IF NOT EXISTS student (
	student_id SERIAL PRIMARY KEY,
	username VARCHAR(128) NOT NULL
);
DROP TABLE IF EXISTS teachers;
DROP TABLE IF EXISTS student;

CREATE TABLE IF NOT EXISTS "Student" (
	student_id SERIAL PRIMARY KEY,
	"Username" VARCHAR(128) UNIQUE NOT NULL,
	password VARCHAR (128) NOT NULL,
	year_born TIMESTAMP NOT NULL,
	updated_on TIMESTAMP
);

DROP TABLE IF EXISTS "Student";

CREATE TABLE IF NOT EXISTS employee (
	employee_id SERIAL PRIMARY KEY,
	name VARCHAR (128) UNIQUE NOT NULL,
	in_core BOOLEAN NOT NULL DEFAULT FALSE,
	year_born TIMESTAMP NOT NULL,
	in_company_since DATE NOT NULL,
	email VARCHAR (50) --DEFAULT name@commail.io 
 
);

DROP TABLE IF EXISTS employee;

INSERT INTO employee(name, in_core, year_born, in_company_since, email)
VALUES ('Momo', TRUE, '2000-01-16 19:10:25-07', '2020-01-16 19:10:25-07', 'bubu@halox.io')
--bez
INSERT INTO employee(name, year_born, in_company_since, email)
VALUES ('Aomo', '2010-01-16 19:10:25-07', '2021-01-16 19:10:25-07', 'bubua@halox.io')

INSERT INTO employee (name, in_core, year_born, in_company_since, email) VALUES (N'Adams', True, '1962/2/18', '2002/8/14', N'andrew@chinookcorp.com');
INSERT INTO employee (name, in_core, year_born, in_company_since, email) VALUES (N'Adamsa', True, '1963/2/18', '1999/8/14', N'a987@chinookcorp.com');
INSERT INTO employee (name, in_core, year_born, in_company_since, email) VALUES (N'Adamss', False, '1962/2/18', '2002/8/1', N'an45drew@chinookcorp.com');
INSERT INTO employee (name, in_core, year_born, in_company_since, email) VALUES (N'Adamsd', True, '1962/2/18', '2002/8/4', N'andrasdew@chinookcorp.com');

-- 
CREATE TABLE student (
	student_id serial PRIMARY KEY,
	username VARCHAR (128) UNIQUE NOT NULL,
	password VARCHAR (128) NOT NULL,
	is_new BOOLEAN,
	year_born INTEGER NOT NULL,
	created_on TIMESTAMP NOT NULL,
    updated_on TIMESTAMP
)

DROP TABLE IF EXISTS student;

INSERT INTO student(username, "password", is_new, year_born, created_on,  updated_on)
VALUES ('Ado', 'Hesloo', TRUE, 1885, '2021-01-16 19:10:25-07', '2021-01-16 19:10:25-07')

INSERT INTO student(username, "password", is_new, year_born, created_on, updated_on)
VALUES ('Michal', 'Heslo', TRUE, 1996, '2021-01-16 19:10:25-07', '2021-01-16 19:10:25-07')

-- specifikovanie serial
INSERT INTO student(student_id, username, "password", is_new, year_born, created_on, updated_on)
VALUES (100, 'momo', 'Hesslo', TRUE, 1977, '2020-01-16 19:10:25-07', '2020-01-16 19:10:25-07')

--viacero
--kapitalky zamerne pre to v ""
CREATE TABLE "Employee"
(
    "EmployeeId" INT NOT NULL,
    "LastName" VARCHAR(20) NOT NULL,
    "FirstName" VARCHAR(20) NOT NULL,
    "Title" VARCHAR(30),
    "ReportsTo" INT,
    "BirthDate" TIMESTAMP,
    "HireDate" TIMESTAMP,
    "Address" VARCHAR(70),
    "City" VARCHAR(40),
    "State" VARCHAR(40),
    "Country" VARCHAR(40),
    "PostalCode" VARCHAR(10),
    "Phone" VARCHAR(24),
    "Fax" VARCHAR(24),
    "Email" VARCHAR(60),
    CONSTRAINT "PK_Employee" PRIMARY KEY  ("EmployeeId") --constraint specifikovany extra
);
DROP TABLE IF EXISTS "Employee";

INSERT INTO "Employee" ("EmployeeId", "LastName", "FirstName", "Title", "BirthDate", "HireDate", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email") VALUES (1, N'Adams', N'Andrew', N'General Manager', '1962/2/18', '2002/8/14', N'11120 Jasper Ave NW', N'Edmonton', N'AB', N'Canada', N'T5K 2N1', N'+1 (780) 428-9482', N'+1 (780) 428-3457', N'andrew@chinookcorp.com');
INSERT INTO "Employee" ("EmployeeId", "LastName", "FirstName", "Title", "ReportsTo", "BirthDate", "HireDate", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email") VALUES (2, N'Edwards', N'Nancy', N'Sales Manager', 1, '1958/12/8', '2002/5/1', N'825 8 Ave SW', N'Calgary', N'AB', N'Canada', N'T2P 2T3', N'+1 (403) 262-3443', N'+1 (403) 262-3322', N'nancy@chinookcorp.com');
INSERT INTO "Employee" ("EmployeeId", "LastName", "FirstName", "Title", "ReportsTo", "BirthDate", "HireDate", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email") VALUES (3, N'Peacock', N'Jane', N'Sales Support Agent', 2, '1973/8/29', '2002/4/1', N'1111 6 Ave SW', N'Calgary', N'AB', N'Canada', N'T2P 5M5', N'+1 (403) 262-3443', N'+1 (403) 262-6712', N'jane@chinookcorp.com');
INSERT INTO "Employee" ("EmployeeId", "LastName", "FirstName", "Title", "ReportsTo", "BirthDate", "HireDate", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email") VALUES (4, N'Park', N'Margaret', N'Sales Support Agent', 2, '1947/9/19', '2003/5/3', N'683 10 Street SW', N'Calgary', N'AB', N'Canada', N'T2P 5G3', N'+1 (403) 263-4423', N'+1 (403) 263-4289', N'margaret@chinookcorp.com');
INSERT INTO "Employee" ("EmployeeId", "LastName", "FirstName", "Title", "ReportsTo", "BirthDate", "HireDate", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email") VALUES (5, N'Johnson', N'Steve', N'Sales Support Agent', 2, '1965/3/3', '2003/10/17', N'7727B 41 Ave', N'Calgary', N'AB', N'Canada', N'T3B 1Y7', N'1 (780) 836-9987', N'1 (780) 836-9543', N'steve@chinookcorp.com');
INSERT INTO "Employee" ("EmployeeId", "LastName", "FirstName", "Title", "ReportsTo", "BirthDate", "HireDate", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email") VALUES (6, N'Mitchell', N'Michael', N'IT Manager', 1, '1973/7/1', '2003/10/17', N'5827 Bowness Road NW', N'Calgary', N'AB', N'Canada', N'T3B 0C5', N'+1 (403) 246-9887', N'+1 (403) 246-9899', N'michael@chinookcorp.com');
INSERT INTO "Employee" ("EmployeeId", "LastName", "FirstName", "Title", "ReportsTo", "BirthDate", "HireDate", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email") VALUES (7, N'King', N'Robert', N'IT Staff', 6, '1970/5/29', '2004/1/2', N'590 Columbia Boulevard West', N'Lethbridge', N'AB', N'Canada', N'T1K 5N8', N'+1 (403) 456-9986', N'+1 (403) 456-8485', N'robert@chinookcorp.com');
INSERT INTO "Employee" ("EmployeeId", "LastName", "FirstName", "Title", "ReportsTo", "BirthDate", "HireDate", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email") VALUES (8, N'Callahan', N'Laura', N'IT Staff', 6, '1968/1/9', '2004/3/4', N'923 7 ST NW', N'Lethbridge', N'AB', N'Canada', N'T1H 1Y8', N'+1 (403) 467-3351', N'+1 (403) 467-8772', N'laura@chinookcorp.com');
-- N'Juháščíkän' varchar s unicode  
