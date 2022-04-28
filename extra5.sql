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

ALTER TABLE "Invoice" ADD CONSTRAINT "FK_InvoiceCustomer"
	FOREIGN KEY ("CustomerId") REFERENCES "Customer"("CustomerId") ON DELETE NO ACTION ON UPDATE NO ACTION;
	-- ON DELETE SET NULL
	-- ON DELETE CASCADE -- znamaz aj to o s suvis
	-- ON DELETE SET DEFAULT
	-- ON DELETE NO ACTION ON UPDATE

DROP TABLE IF EXISTS car;
CREATE TABLE car (
	car_id INT NOT NULL,
	brand VARCHAR(128) NOT NULL,
	customer_id INT NOT NULL,
	CONSTRAINT pk_car PRIMARY KEY (car_id),
	CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES "Customer" ("CustomerId") ON DELETE NO ACTION ON UPDATE NO ACTION
);

INSERT INTO "Customer" ("CustomerId", "FirstName", "LastName", "Company", "Address", "City", "State", "Country", "PostalCode", "Phone", "Fax", "Email", "SupportRepId") VALUES (1, N'Luís', N'Gonçalves', N'Embraer - Empresa Brasileira de Aeronáutica S.A.', N'Av. Brigadeiro Faria Lima, 2170', N'São José dos Campos', N'SP', N'Brazil', N'12227-000', N'+55 (12) 3923-5555', N'+55 (12) 3923-5566', N'luisg@embraer.com.br', 3);
INSERT INTO car (car_id, brand, customer_id) VALUES (1, 'BMW', 1);

SELECT * FROM car

ALTER TABLE car 
	DROP CONSTRAINT fk_customer,
	ADD CONSTRAINT fk_customer FOREIGN KEY (customer_id) REFERENCES "Customer" ("CustomerId") ON DELETE CASCADE ON UPDATE NO ACTION

DELETE FROM "Customer" where "CustomerId" = 1;



