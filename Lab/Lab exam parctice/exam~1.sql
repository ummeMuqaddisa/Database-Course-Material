DROP TABLE authors CASCADE CONSTRAINTS;
DROP TABLE books CASCADE CONSTRAINTS;
DROP TABLE genre CASCADE CONSTRAINTS;

CREATE TABLE authors (
author_id NUMBER,
author_name VARCHAR2(20),
birth_year NUMBER NOT NULL,
CONSTRAINT A PRIMARY KEY(author_id)
);
CREATE TABLE books(
book_id NUMBER,
title VARCHAR2(20),
author_id NUMBER,
genre_id NUMBER,
oub_year NUMBER,
price NUMERIC,
CONSTRAINT b PRIMARY KEY(book_id),
CONSTRAINT Afk FOREIGN KEY(author_id) REFERENCES authors(author_id),
CONSTRAINT gfk FOREIGN KEY(genre_id) REFERENCES genre(genre_id),
CONSTRAINT pfk CHECK(price<2000)
);
CREATE TABLE genre(

genre_id NUMBER,
genre_name VARCHAR2(20),
CONSTRAINT g PRIMARY KEY(genre_id)
);

INSERT INTO authors (author_id, author_name, birth_year) VALUES(1, 'Muhammad Yunus', 1940);
INSERT INTO authors (author_id, author_name, birth_year) VALUES(2, 'Taslima Nasrin', 1962);
INSERT INTO authors (author_id, author_name, birth_year) VALUES(3, 'Humayun Ahmed', 1948);
INSERT INTO authors (author_id, author_name, birth_year) VALUES(4, 'Jafor Iqbal', 1952);
INSERT INTO authors (author_id, author_name, birth_year) VALUES(5, 'Rabindranath Tagore', 1861);



-- Inserting data into Books table
INSERT INTO Books (book_id,title,author_id,oub_year,price,genre_id)  VALUES(1, 'Aaj Himur Biye', 3, 2019, 450.50, 1);
INSERT INTO Books (book_id,title,author_id,oub_year,price,genre_id) VALUES(2, 'Opekkha', 3, 1997, 380.00, 1);
INSERT INTO Books (book_id,title,author_id,oub_year,price,genre_id)  VALUES(3, 'Ami Topu', 4, 2005, 499.99, 4);
INSERT INTO Books (book_id,title,author_id,oub_year,price,genre_id) VALUES(4, 'Gitanjali', 5, 1910, 600.00, 3);
INSERT INTO Books (book_id,title,author_id,oub_year,price,genre_id) VALUES(5, 'Grameen Bank Stories', 1, 2000, 800.75, 1);

-- Inserting data into Genres table
INSERT INTO Genre (genre_id, genre_name) VALUES(1, 'Social Fiction');
INSERT INTO Genre (genre_id, genre_name) VALUES(2, 'Biography');
INSERT INTO Genre (genre_id, genre_name) VALUES(3, 'Romance');
INSERT INTO Genre (genre_id, genre_name) VALUES(4, 'Drama');
INSERT INTO Genre (genre_id, genre_name) VALUES(5, 'Historical');



SELECT * FROM genre;
SELECT * FROM books;

SELECT title,author_name FROM authors JOIN books USING (author_id)
WHERE oub_year>2000;


SELECT author_id, author_name, birth_year FROM authors JOIN books USING (author_id)
WHERE price >= ALL (SELECT price FROM books JOIN authors USING (author_id));


SELECT genre_id,genre_name  FROM books JOIN genre USING ( genre_id) 
GROUP BY genre_name,genre_id
HAVING count(*)>1;


SELECT UPPER (author_name),birth_year FROM authors WHERE author_name
LIKE ('%a%a%a%');



CREATE OR REPLACE VIEW AuthorP  AS
SELECT author_name,sum(price) AS total_price FROM  authors JOIN books USING(author_id) 
GROUP BY author_name ORDER BY sum(price);




