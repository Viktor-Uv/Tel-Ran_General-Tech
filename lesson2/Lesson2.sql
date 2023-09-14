USE hr;

SELECT *
FROM locations;


-- ================= --

USE learn;

SELECT title
     , price
--     , discount   -- comma format option
FROM products
WHERE title IS NOT NULL;

SELECT *
FROM products;

SELECT title,
       price,
       CASE
           WHEN price <= 10000
               THEN 1
           WHEN price <= 20000
               THEN 2
           WHEN price <= 30000
               THEN 3
           ELSE 4
           END AS price_proup -- 'virtual' column with some data
FROM products;


-- ================= --

USE hr;

SELECT first_name,
       last_name,
       salary,
       IF(salary <= 10000, 0, 1) AS 'salary_group'
FROM employees;


-- ================= --

USE learn;

SELECT title,
       price,
       price * ( -- need to avoid null
           CASE
               WHEN discount IS NULL
                   THEN 1
               ELSE discount
               END
           ) AS price_with_discount
FROM products; -- better solution below:

SELECT title,
       price,
       price * COALESCE(discount, 1) AS price_with_discount
-- COALESCE(VALUE IF NOT NULL, VALUE IF NULL)
FROM products;
-- better solution of above

-- Sorting
SELECT title,
       price,
       price * COALESCE(discount, 1) AS price_with_discount
FROM products
ORDER BY price DESC; -- DESC: reversed order

SELECT title,
       price,
       price * COALESCE(discount, 1) AS price_with_discount
FROM products
ORDER BY price DESC, title;


-- ================= --

USE hr;

SELECT *
FROM employees;

-- Unique values
SELECT DISTINCT job_id
FROM employees;

SELECT first_name,
       last_name
FROM employees
ORDER BY first_name DESC, last_name DESC;

# print all employees in departments 60, 90, 110 and sort by last_name
SELECT first_name,
       last_name
FROM employees
WHERE department_id IN (60, 90, 110)
ORDER BY last_name;


-- ================= --

USE learn;

-- math operators
SELECT price,
       price * 2        AS double_price,
       price - 5000     AS price_one,
       price + 5000     AS price_two,
       price / 5000     AS price_three,
       price % 2        AS price_four,
       price * discount AS new_price
FROM products;

-- base functions
SELECT -1 AS value;
SELECT ABS(-2) AS value;
SELECT POW(3, 2) AS value;
SELECT SQRT(144) AS value;
SELECT ROUND(3.6) AS value;

-- string functions
SELECT CONCAT('Hello', ' ', 'World'); -- Hello World
SELECT CONCAT_WS('-', 'hello', 'world', 2023); -- hello-world-2023

SELECT LENGTH('Hello'); -- 5 (1 letter - 1 byte)
SELECT LENGTH('Привет'); -- 12 (1 letter - 2 bytes)

SELECT TRIM('    hello    world    '); -- |hello    world|
SELECT LTRIM('    hello    world    '); -- |hello    world    |
SELECT RTRIM('    hello    world    '); -- |    hello    world|

SELECT LOWER('HeLLo'); -- hello
SELECT UPPER('HeLLo'); -- HELLO

SELECT SUBSTRING('hello world', 5, 3); -- o w
SELECT REPLACE('49-555-666-777', '-', ' ');
SELECT INSERT('hello world', 7, 5, 'class'); -- hello class


-- ================= --
USE airport;

SELECT *
FROM airliners;

/*
 add new column category,
 where liners with distance from 1000 to 2500 - short
 where liners with distance from 2500 to 6000 - medium
 where liners with distance from 6000 to ---- - long
 */
SELECT model_name,
       production_year,
       distance,
       CASE
           WHEN distance > 1000 AND distance <= 2500
               THEN 'short'
           WHEN distance > 2500 AND distance <= 6000
               THEN 'medium'
           WHEN distance > 6000
               THEN 'long'
           END AS category
FROM airliners;
