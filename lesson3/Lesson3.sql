USE learn;

DROP TABLE students; -- remove table of data
DROP TABLE IF EXISTS students; -- another option

CREATE TABLE students
(
    name    VARCHAR(64),  -- Varchar - Strings
    surname VARCHAR(64),
    age     INTEGER,      -- int
    rate    NUMERIC(8, 3) -- Float (размерность числа, размерность дроби)
); -- table schema creation

SELECT *
FROM students;

INSERT INTO students -- must insert data in every field
VALUES ('Alex', 'Alexeev', 35, 20); -- insert data option 1

INSERT INTO students (name, surname, age) -- data field selection
VALUES ('Alex', 'Alexeev', 35); -- insert data option 2

INSERT INTO students (name, surname, age)
VALUES ('Alex', 'Alexeev', 35), -- multiple data insertion
       ('Oleg', 'Olegov', 20),
       ('Maxim', 'Maximov', 40); -- insert data option 3


-- ================= --
USE hr;

CREATE TABLE students
(
    name    VARCHAR(64),
    surname VARCHAR(64),
    age     INTEGER,
    rate    NUMERIC(8, 3)
);

INSERT INTO students (name, surname) -- insert data from another table
SELECT first_name, -- result of selection from another table
       last_name
FROM employees; -- insert data option 4

SELECT *
FROM students;


-- ================= --
USE learn;

INSERT INTO students
SET name = 'Elena',
    age  = 25; -- insert data option 5


/*
 SQL Language Statements:

 DML - Data Manipulation Language. Works with data inside the tables
    SELECT, INSERT, UPDATE, DELETE, MERGE, JOIN, ...

 DDL - Data Definition Language. Works with table's structure
    CREATE, ALTER, DROP, TRUNCATE, RENAME, ...

 DCL - Data Control Language. Works with access rights
    GRANT, REVOKE, DENY, ...

 TCL - Transaction Control Language. Works with transactions within DB
    BEGIN, TRAN, COMMIT, ROLLBACK, ...
 */

SET SQL_SAFE_UPDATES = 0; -- disable safe mode of the development environment

DELETE
FROM students -- deletes line-by-line
WHERE rate IS NULL; -- possible to restore

SELECT *
FROM students;

TRUNCATE TABLE students;
-- deletes everything in one go, can't restore
-- but works fast

UPDATE students
SET rate = 0; -- overrides all data in whole column 'rate'

UPDATE students
SET rate = 0
WHERE rate IS NULL; -- safe option with WHERE

UPDATE students
SET rate = rate + 10; -- increments all data in whole column 'rate'

UPDATE students
SET rate = 50,
    age  = 25
WHERE name = 'Oleg'; -- update multiple data with condition

UPDATE students
SET rate = 40,
    age  = 20
WHERE name = 'Alex';


INSERT INTO students (name, surname, age)
VALUES ('Alex', 'Smirnoff', 35), -- multiple data insertion
       ('Oleg', 'Alexeev', 20),
       ('Maxim', 'Olegov', 15);

CREATE TABLE new_students AS -- create new table from result of SELECT
SELECT *
FROM students
WHERE age < 25; -- saves data that can possibly become outdated

SELECT *
FROM new_students;

CREATE TABLE new_students_v2 AS -- create new table from result of SELECT
SELECT name,
       age
FROM students
WHERE age < 25; -- saves data that can possibly become outdated

SELECT *
FROM new_students_v2;

-- VIEW name convention: starts with 'v_'
CREATE VIEW v_new_students_v2 AS -- create 'virtual' table
SELECT name,
       age
FROM students
WHERE age < 25; -- will execute code that always requests actual data

SELECT *
FROM v_new_students_v2;

SELECT *
FROM products;


/*
create two views - one with products with price less than 20000,
                   other with price more than 20000
*/
CREATE VIEW v_price_less_than_20000 AS
SELECT *
FROM products
WHERE price < 20000;

SELECT *
FROM v_price_less_than_20000;

CREATE VIEW v_price_more_than_20000 AS
SELECT *
FROM products
WHERE price >= 20000;

SELECT *
FROM v_price_more_than_20000;


SELECT *
FROM students;

ALTER TABLE students
    ADD middlename VARCHAR(64); -- shortened syntax, also works in MySQL

ALTER TABLE students
    ADD COLUMN middlename VARCHAR(64); -- full syntax

ALTER TABLE students
    DROP COLUMN rate;

ALTER TABLE students
    MODIFY middlename VARCHAR(10);

ALTER TABLE students
    MODIFY COLUMN middlename VARCHAR(128);

ALTER TABLE students
    CHANGE middlename middle_name VARCHAR(128); -- change column name syntax 1

ALTER TABLE students
    RENAME COLUMN middle_name TO middle; -- change column name syntax 2
