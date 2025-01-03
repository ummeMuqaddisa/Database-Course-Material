DROP TABLE P CASCADE CONSTRAINT;
DROP TABLE D CASCADE CONSTRAINT;
DROP TABLE A CASCADE CONSTRAINT;

CREATE TABLE P(
p_id NUMBER,
p_name VARCHAR2(20),
gender VARCHAR2(20),
ad_date DATE,
dis_date DATE,
med_condition VARCHAR2(20),
CONSTRAINT ppfk PRIMARY  KEY (p_id)
);

 CREATE TABLE D (
 d_id NUMBER,
 d_name VARCHAR2(20),
 specialization VARCHAR2(20),
 con_number NUMBER,
 salary NUMBER,
 CONSTRAINT dd PRIMARY  KEY (d_id)
);

CREATE TABLE A(
ad_id NUMBER,
p_id NUMBER,
d_id NUMBER,
CONSTRAINT pp FOREIGN KEY (p_id) REFERENCES P(p_id),
CONSTRAINT pd FOREIGN KEY (d_id) REFERENCES D(d_id)
);
INSERT INTO P  VALUES (101, 'Muhammad Yunus', 'Male', TO_DATE ('2023-08-01','yyyy-mm-dd'), TO_DATE('2023-08-19','yyyy-mm-dd'), 'Flu');
INSERT INTO P  VALUES (102, 'Taslima Nasrin', 'Female',TO_DATE ('2024-08-03','yyyy-mm-dd'),TO_DATE ('2024-08-12','yyyy-mm-dd'), 'Fractured Leg');
INSERT INTO P  VALUES (103, 'Humayun Ahmed', 'Male',TO_DATE ('2024-04-11','yyyy-mm-dd'), TO_DATE('2024-04-23','yyyy-mm-dd'), 'Appendicitis');
INSERT INTO P  VALUES (104, 'Jafor Iqbal', 'Male',TO_DATE ('2024-04-08','yyyy-mm-dd'),TO_DATE ('2024-05-11','yyyy-mm-dd'), 'Pneumonia');

-- Insert data into Doctors table
INSERT INTO D VALUES (201, 'Dr. Jahid', 'Neurology', '01798346011', 45000);
INSERT INTO D VALUES (202, 'Dr. Kabir', 'Orthopedics', '01997085841', 67000);
INSERT INTO D VALUES (203, 'Dr. Topu', 'Cardiology', '01844447005', 80000);
INSERT INTO D VALUES (204, 'Dr. Gitanjali', 'Neurology', '01711910555', 90000);

-- Insert data into Admissions table
INSERT INTO A  VALUES (301, 101, 201);
 INSERT INTO A  VALUES (302, 102, 202);
INSERT INTO A  VALUES (303, 103, 201);
INSERT INTO A  VALUES (304, 104, 204);


SELECT * FROM P;
SELECT * FROM D;
SELECT * FROM A;

SELECT TO_CHAR (ad_date,'mm'),p_name FROM P;

SELECT d_name FROM D 
WHERE salary <= ALL (SELECT salary FROM D);


WITH Total (dn,value) AS
(SELECT d_name,COUNT(p_id) AS Cp_id FROM D JOIN A using (d_id) GROUP BY d_name),
AVrG(value2) AS
(SELECT avg(value) AS YT FROM Total)

SELECT dn FROM Total,AVrG 
WHERE Total.value>AVrG.value2;


SELECT * FROM P
WHERE gender='Male' AND UPPER(p_name) LIKE '%M%N%';

SELECT p_name FROM P
WHERE p_id IN
(SELECT p_id FROM  P JOIN A  USING (p_id) GROUP BY p_id HAVING COUNT(DISTINCT d_id) >1)
ORDER BY p_name DESC;

CREATE OR REPLACE VIEW   AD_UNDER_NEU AS
SELECT p_name FROM P JOIN A USING (p_id) 
JOIN D USING (d_id) 
WHERE  specialization='Neurology';

SELECT * FROM AD_UNDER_NEU;



