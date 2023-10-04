USE learn;

DROP TABLE IF EXISTS students;

# Constrains:
-- NOT NULL
-- CHECK
-- UNIQUE
-- PRIMARY KEY == NOT NULL && UNIQUE

CREATE TABLE students
(
    id      INTEGER PRIMARY KEY, -- index automatically created for PRIMARY KEY
    name    VARCHAR(64) NOT NULL,
    surname VARCHAR(64) NOT NULL,
    age     INTEGER CHECK (age BETWEEN 18 AND 120),
    phone   VARCHAR(32) UNIQUE
);

SELECT *
FROM students;

INSERT INTO students (id, name, surname, age, phone)
VALUES (1, 'Alex', 'Alexeev', 35, '777-888-999');

# INSERT INTO students (id, name, surname, age, phone)
# VALUES (1, 'Alex', 'Alexeev', 35, '777-888-999');
-- [23000][1062] Duplicate entry '1' for key 'students.PRIMARY'

# INSERT INTO students (id, name, surname, age, phone)
# VALUES (2, 'Alex', 'Alexeev', 35, '777-888-999');
-- [23000][1062] Duplicate entry '777-888-999' for key 'students.phone'

INSERT INTO students (id, name, surname, age, phone)
VALUES (2, 'Alex', 'Alexeev', 35, '777-888-000');

# INSERT INTO students (id, name, surname, age, phone)
# VALUES (3, 'Alex', 'Alexeev', 17, '777-888-000');
-- [HY000][3819] Check constraint 'students_chk_1' is violated.

# INSERT INTO students (id, name, surname, age, phone)
# VALUES (3, 'Alex', NULL, 20, '777-888-001');
-- [23000][1048] Column 'surname' cannot be null

# INSERT INTO students (id, name, age, phone)
# VALUES (3, 'Alex', 40, '777-888-001');
-- [HY000][1364] Field 'surname' doesn't have a default value


-- ================= --
DROP TABLE IF EXISTS students;

-- add AUTO_INCREMENT for id:
CREATE TABLE students
(
    id      INTEGER PRIMARY KEY AUTO_INCREMENT,
    name    VARCHAR(64) NOT NULL,
    surname VARCHAR(64) NOT NULL,
    age     INTEGER CHECK (age BETWEEN 18 AND 120),
    phone   VARCHAR(32) UNIQUE
);

SELECT *
FROM students;

INSERT INTO students (name, surname, age, phone)
VALUES ('Alex', 'Alexeev', 35, '777-888-999');

INSERT INTO students (name, surname, age, phone)
VALUES ('Alex', 'Alexeev', 35, '777-888-000');

INSERT INTO students (name, surname, age, phone)
VALUES ('Alex', 'Alexeev', 40, '777-888-001');

SET SQL_SAFE_UPDATES = 0;
-- turn off safety feature of 'workbench'.
-- In console not required

DELETE
FROM students
WHERE age < 50;

INSERT INTO students (name, surname, age, phone)
VALUES ('Alex', 'Alexeev', 35, '777-888-999'),
       ('Alex', 'Alexeev', 35, '777-888-000'),
       ('Alex', 'Alexeev', 40, '777-888-001');
-- id continues (4, 5, 6)

TRUNCATE TABLE students;

INSERT INTO students (name, surname, age, phone)
VALUES ('Alex', 'Alexeev', 35, '777-888-999'),
       ('Alex', 'Alexeev', 35, '777-888-000'),
       ('Alex', 'Alexeev', 40, '777-888-001');
-- id resets (1, 2, 3)


-- ================= --
DROP TABLE IF EXISTS students;

-- add DEFAULT value for surname:
CREATE TABLE students
(
    id      INTEGER PRIMARY KEY AUTO_INCREMENT,
    name    VARCHAR(64) NOT NULL,
    surname VARCHAR(64) NOT NULL DEFAULT '',
    age     INTEGER CHECK (age BETWEEN 18 AND 120),
    phone   VARCHAR(32) UNIQUE
);

SELECT *
FROM students;

INSERT INTO students (name, surname, age, phone)
VALUES ('Alex', 'Alexeev', 35, '777-888-999'),
       ('Alex', 'Alexeev', 35, '777-888-000'),
       ('Alex', 'Alexeev', 40, '777-888-001');

INSERT INTO students (name, age, phone)
VALUES ('Alex', 40, '777-888-002');


-- ================= --
DROP TABLE IF EXISTS students;

/* Task 1
students:
name, lastname - ne null
avg_mark - from 0 to 5.   numeric(2,1)
gender "M" "F"
varchar 128
 */
CREATE TABLE students
(
    name     VARCHAR(128) NOT NULL,
    lastname VARCHAR(128) NOT NULL,
    avg_mark NUMERIC(2, 1) CHECK (avg_mark BETWEEN 0 AND 5),
    gender   VARCHAR(128) CHECK (gender IN ('M', 'F'))
);

/*
 Task 2
 fill the table
 */
INSERT INTO students (name, lastname, avg_mark, gender)
VALUES ('Oleg', 'Petrov', 4.3, 'M'),
       ('Semen', 'Stepanov', 3.1, 'M'),
       ('Olga', 'Semenova', 4.7, 'F'),
       ('Igor', 'Romanov', 3.1, 'M'),
       ('Irina', 'Ivanova', 2.2, 'F');

SELECT *
FROM students;

/*
 Task 3
 add id integer primary key auto_increment
 */

ALTER TABLE students
    ADD COLUMN id INTEGER PRIMARY KEY AUTO_INCREMENT;


-- ================= --
# UNION, UNION ALL (append new rows vertically)

CREATE TABLE goods
(
    id       INTEGER PRIMARY KEY AUTO_INCREMENT,
    title    VARCHAR(32),
    quantity INTEGER CHECK (quantity > 0),
    in_stock CHAR(1) CHECK (in_stock IN ('Y', 'N'))
);

CREATE TABLE goods_two
(
    id       INTEGER PRIMARY KEY AUTO_INCREMENT,
    title    VARCHAR(32),
    quantity INTEGER CHECK (quantity > 0),
    price    INTEGER,
    in_stock CHAR(1) CHECK (in_stock IN ('Y', 'N'))
);

INSERT INTO goods (title, quantity, in_stock)
VALUES ('bike', 2, 'Y'),
       ('skates', 4, 'Y'),
       ('skis', 2, 'Y'),
       ('board', 7, 'N'),
       ('scooter', 1, 'N'),
       ('bicycle', 5, 'Y');

INSERT INTO goods_two (title, quantity, price, in_stock)
VALUES ('bike', 2, 500, 'Y'),
       ('skis', 2, 100, 'Y'),
       ('board', 7, 300, 'N'),
       ('scooter', 1, 200, 'N'),
       ('form', 10, 35, 'Y');

SELECT *
FROM goods;

SELECT *
FROM goods_two;

SELECT title
FROM goods
UNION ALL
-- get all results, including duplicates
SELECT title
FROM goods_two;

SELECT title
FROM goods
UNION
-- get results without duplicates
SELECT title
FROM goods_two;

# SELECT id, title, quantity FROM goods
# UNION ALL
# SELECT id, title, quantity, price FROM goods_two;
-- [21000][1222] The used SELECT statements have a different number of columns
-- (number of columns doesn't match)

SELECT id, title, quantity
FROM goods
UNION ALL
SELECT id, title, quantity
FROM goods_two
UNION ALL
SELECT id, title, quantity
FROM goods_two;

SELECT id, title, 0 AS new_price, quantity
FROM goods -- takes column names of top selection
UNION ALL
SELECT id, title, price, quantity
FROM goods_two;
