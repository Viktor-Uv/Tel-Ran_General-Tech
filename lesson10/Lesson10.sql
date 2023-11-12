# Проектирование ДБ

-- Типы связей:
-- 1 : 1 - one to one (with unique on FK)
-- 1 : M - one to many (without unique on FK)
-- M : M - many to many (external keys are stored in a separate tables)

CREATE DATABASE test_school;

USE test_school;

CREATE TABLE students
(
    id      INT PRIMARY KEY AUTO_INCREMENT,
    name    VARCHAR(255),
    surname VARCHAR(255)
);

CREATE TABLE passports
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    number     VARCHAR(10),
    student_id INT UNIQUE,
    FOREIGN KEY (student_id) REFERENCES students (id)
);

INSERT INTO students (name, surname)
VALUES ('Alex', 'Alexeev'),
       ('Oleg', 'Olegov');

SELECT *
FROM students;

SELECT *
FROM passports;

INSERT INTO passports (number, student_id)
VALUES #('555555', 3), # inserting non-existing student ID - results in ERROR
       ('555555', 2),
       ('333333', 1);
#('222222', 1); # - results in ERROR


-- =============== --
-- M : M

CREATE TABLE shops
(
    id   INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100)
);

CREATE TABLE customers
(
    id      INT PRIMARY KEY AUTO_INCREMENT,
    name    VARCHAR(128),
    surname VARCHAR(125)
);

CREATE TABLE shop2customer
(
    shop_id     INT,
    customer_id INT,
    FOREIGN KEY (shop_id) REFERENCES shops (id),
    FOREIGN KEY (customer_id) REFERENCES customers (id)
);

INSERT INTO shops (name)
VALUES ('Amazon'),
       ('Walmart'),
       ('Ebay');

INSERT INTO customers (name, surname)
VALUES ('Alex', 'Alexeev'),
       ('Oleg', 'Olegov'),
       ('Maxim', 'Maximov');

SELECT *
FROM shops;

SELECT *
FROM customers;

INSERT INTO shop2customer (shop_id, customer_id)
VALUES (1, 1),
       (3, 1),
       (1, 2),
       (3, 2),
       (2, 2);

SELECT *
FROM shop2customer;

SELECT shops.*,
       cust.name,
       cust.surname
FROM shops
         INNER JOIN shop2customer s2c
                    ON shops.id = s2c.shop_id
         INNER JOIN customers cust
                    ON cust.id = s2c.customer_id
WHERE shops.id = 3;

SELECT shops.*,
       cust.name,
       cust.surname
FROM shops
         INNER JOIN shop2customer s2c
                    ON shops.id = s2c.shop_id
         INNER JOIN customers cust
                    ON cust.id = s2c.customer_id
WHERE cust.id = 2;

SELECT *
FROM customers cust
         INNER JOIN shop2customer s2c
                    ON cust.id = s2c.customer_id
         INNER JOIN shops
                    ON s2c.shop_id = shops.id;


-- =============== --

CREATE TABLE studentsTwo
(
    id      INT PRIMARY KEY AUTO_INCREMENT,
    name    VARCHAR(255),
    surname VARCHAR(255)
);

CREATE TABLE passportsTwo
(
    id         INT PRIMARY KEY AUTO_INCREMENT,
    number     VARCHAR(10),
    student_id INT UNIQUE,
    FOREIGN KEY (student_id) REFERENCES studentsTwo (id) ON DELETE CASCADE
); # 'ON DELETE CASCADE' - will delete entry if primary entry has been deleted

INSERT INTO studentsTwo (name, surname)
VALUES ('Alex', 'Alexeev'),
       ('Oleg', 'Olegov');

INSERT INTO passportsTwo (number, student_id)
VALUES ('555555', 2),
       ('333333', 1);

SELECT *
FROM studentsTwo;

SELECT *
FROM passportsTwo;

DELETE
FROM studentsTwo
WHERE id = 2; # will delete primary entry as well

DELETE
FROM students
WHERE id = 2; # will result in an error, as 'ON DELETE CASCADE' is missing, but dependency exists




-- =============== --

-- NF - нормальные формы (нормализация баз данных)

/*
 ======================================================

 1NF - первая нормальная форма (atomic value , unique lines, отсутствуют составные данные).
    Отношение находится в 1НФ, если все его атрибуты являются простыми, все используемые домены
    должны содержать только скалярные значения. Не должно быть повторений строк в таблице.

 Source table:
 +--------+---------------+
 | Maker  | Model         |
 +--------+---------------+
 | BMW    | M5, X5, X1    |
 | NISSAN | GT-R, SkyLine |
 +--------+---------------+

 Source table in 1NF:
 +--------+---------+
 | Maker  | Model   |
 +--------+---------+
 | BMW    | M5      |
 | BMW    | X5      |
 | BMW    | X1      |
 | NISSAN | GT-R    |
 | NISSAN | SkyLine |
 +--------+---------+

 ======================================================

 2NF - вторая нормальная форма (1NF + PK + неключевые столбцы должны зависеть от PK)
    Отношение находится во 2NF, если оно находится в 1NF и каждый не ключевой атрибут
    неприводимо зависит от первичного ключа (PK).
    Вторая форма ликвидирует зависимости неключевых полей от части ключа.

 Source table:
 +--------+---------+-------+----------+
 | Maker  | Model   | Price | Discount |
 +--------+---------+-------+----------+
 | BMW    | M5      | 10000 | 5        |
 | BMW    | X5      | 20000 | 5        |
 | BMW    | X1      | 15000 | 5        |
 | NISSAN | GT-R    | 1000  | 10       |
 | NISSAN | SkyLine | 30000 | 10       |
 +--------+---------+-------+----------+

 Source table in 2NF:
 +----+--------+---------+-------+                          +----+--------+----------+
 | ID | Maker  | Model   | Price |                          | ID | Maker  | Discount |
 +----+--------+---------+-------+                          +----+--------+----------+
 | 1  | BMW    | M5      | 10000 |                          | 1  | BMW    | 5        |
 | 2  | BMW    | X5      | 20000 |                          | 2  | NISSAN | 10       |
 | 3  | BMW    | X1      | 15000 |                          +----+--------+----------+
 | 4  | NISSAN | GT-R    | 1000  |
 | 5  | NISSAN | SkyLine | 30000 |
 +----+--------+---------+-------+

 ------------------------------------------------------

 Source table (2nd example):
 Contacts
 +----+------+-------------+-------------+-------+----------+
 | ID | s_id | phone_no    | operator    | found | office   |
 +----+------+-------------+-------------+-------+----------+
 | 1  | 1    | +9055454554 | TurkTelecom | 1950  | Istanbul |
 +----+------+-------------+-------------+-------+----------+

 Source table in 2NF (2nd example):
 Students                                                   Providers
 +----+------+-------------+-------------+                  +----+-------------+------+----------+
 | id | s_id | Tel         | provider_id |                  | id | operator    | found | office  |
 +----+------+-------------+-------------+                  +----+-------------+------+----------+
 | 1  | 1    | +9055454554 | 1	         |                  | 1  | TurkTelecom | 1950 | Istanbul |
 +----+------+-------------+-------------+                  +----+-------------+------+----------+

 ------------------------------------------------------

 Source table (3rd example):
 Courses
 +----+------+--------+------+-------+
 | id | s_id | Course | OS   | found |
 +----+------+--------+------+-------+
 | 1  | 1    | Java   | UNIX | 1972  |
 +----+------+--------+------+-------+

 Source table in 2NF (3nd example):
 Students                               Courses
 +------+-----------+                   +----+------+------+-------+
 | id   | course_id |                   | id | Name | OS   | found |
 +------+-----------+                   +----+------+------+-------+
 | 255  |    10     |                   | 10 | Java | UNIX | 1972  |
 +------+-----------+                   +----+------+------+-------+

 ======================================================

 3NF - третья нормальная форма (2NF + отсутствие транзитивных зависимостей между неключевыми полями)
    Отношение находится в 3NF, когда находится во 2NF и каждый не ключевой атрибут
    нетранзитивно зависит от первичного ключа (PK).
    Третья нормальная форма исключает зависимость неключевых полей от других неключевых полей.

 Source table:
 +----+--------+------+-------+
 | ID | Maker  | SHOP | PHONE |
 +----+--------+------+-------+
 | 1  | BMW.   | One  | 555   |
 +----+--------+------+-------+
 | 2  | Nissan | Two  | 333   |
 +----+--------+------+-------+

 Source table in 3NF:
 +----+--------+------+                     +------+-------+
 | ID | Mark   | SHOP |                     | SHOP | PHONE |
 +----+--------+------+                     +------+-------+
 | 1  | BMW.   | One. |                     | One. | 555   |
 +----+--------+------+                     +------+-------+
 | 2  | Nissan | Two  |                     | Two  | 333   |
 +----+--------+------+                     +------+-------+

 */
