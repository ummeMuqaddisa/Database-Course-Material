DROP TABLE account CASCADE CONSTRAINT;
DROP TABLE customer CASCADE CONSTRAINT;
DROP TABLE depositer CASCADE CONSTRAINT;

CREATE TABLE account(
account_no CHAR(5),
balance NUMBER NOT NULL,
CONSTRAINT ACC PRIMARY KEY (account_no),
CONSTRAINT BAL CHECK (balance>0)

);


CREATE TABLE customer(
customer_no CHAR(5),
customer_name VARCHAR2(20) NOT NULL,
customer_city VARCHAR2(10),
CONSTRAINT CN PRIMARY KEY (customer_no)

);

CREATE TABLE depositer(
account_no CHAR(5),
customer_no CHAR(5),
CONSTRAINT depo PRIMARY KEY (account_no,customer_no)
);

ALTER TABLE customer ADD date_of_birth DATE;

ALTER TABLE customer DROP COLUMN date_of_birth;



ALTER TABLE depositer RENAME COLUMN account_no TO a_no;
ALTER TABLE depositer  RENAME COLUMN customer_no TO c_no;

SELECT * FROM customer;
DESC depositer ;

ALTER TABLE depositer ADD CONSTRAINT depositor_fk1 FOREIGN KEY(a_no) REFERENCES account (account_no);
ALTER TABLE depositer ADD CONSTRAINT depositor_fk2 FOREIGN KEY(c_no) REFERENCES customer (customer_no);



INSERT INTO  account VALUES('A-101',12000);
INSERT INTO account VALUES('A-102',6000);
INSERT INTO account VALUES('A-103',2500);

INSERT INTO customer VALUES('C-101','Alice','Dhaka');
INSERT INTO customer VALUES('C-102','Annie','Dhaka');
INSERT INTO customer VALUES('C-103','Bob','Chittagong');
INSERT INTO customer VALUES('C-104','Charlie','Khulna');

INSERT INTO depositer VALUES ('A-101','C-101');
INSERT INTO depositer VALUES('A-103','C-102');
INSERT INTO depositer VALUES('A-103','C-104');
INSERT INTO depositer VALUES('A-102','C-103');


SELECT customer_name, customer_city FROM customer;

SELECT DISTINCT customer_city FROM customer;

SELECT account_no FROM account WHERE balance> 7000;

SELECT customer_no,customer_name FROM  customer WHERE customer_city='Khulna';

SELECT customer_no,customer_name FROM  customer WHERE customer_city!='Dhaka';


SELECT customer_name,customer_city 
FROM account 
JOIN depositer
ON account.account_no=depositer.a_no
JOIN customer ON customer.customer_no=depositer.c_no
WHERE account.balance>7000;

SELECT customer_name,customer_city 
FROM account 
JOIN depositer
ON account.account_no=depositer.a_no
JOIN customer ON customer.customer_no=depositer.c_no
WHERE account.balance>7000 AND customer.customer_city!='Khulna';



SELECT account_no, balance
FROM account 
JOIN depositer
ON account.account_no=depositer.a_no
JOIN customer ON customer.customer_no=depositer.c_no
WHERE customer_no='C-102';


SELECT account_no,balance
FROM account 
JOIN depositer
ON account.account_no=depositer.a_no
JOIN customer ON customer.customer_no=depositer.c_no
WHERE customer_city IN ('Khulna','Dhaka');

SELECT customer_name,customer_no
FROM account 
JOIN depositer
ON account.account_no=depositer.a_no
JOIN customer ON customer.customer_no=depositer.c_no
WHERE  account_no IS NULL;













