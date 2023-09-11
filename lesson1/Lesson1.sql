# 07.09.2023
CREATE DATABASE learn;

USE learn; -- switching DB

CREATE TABLE products
( -- creating DB
    id       INTEGER PRIMARY KEY AUTO_INCREMENT,
    title    VARCHAR(128),
    price    INTEGER,
    discount DECIMAL(2, 1)
);

INSERT INTO products (title, price, discount)
VALUES ('bike', 50000, 0.9),
       ('skates', 15000, 0.1),
       ('skis', 25000, NULL),
       ('board', 30000, 0.9),
       ('scooter', 10000, 0.8);

SELECT *
FROM products;

SELECT title,
       price,
       discount
FROM products;

SELECT title AS Name,
       price AS Price
FROM products;

SELECT title             AS Item,
       price             AS Original_price,
       discount,
       price * discount  AS Discounted_price, -- math operations
       'New Year action' AS Sale              -- custom fields
FROM products;

SELECT title,
       price,
       discount
FROM products
WHERE title = 'bike'; -- condition only after selection

SELECT title,
       price,
       discount
FROM products
WHERE price > 20000;

SELECT title,
       price,
       discount
FROM products
WHERE title = 'bike'
   OR title = 'board'; -- can be improved with IN

SELECT title,
       price,
       discount
FROM products
WHERE title IN ('bike', 'board', 'skis'); -- improved version of above

SELECT title,
       price,
       discount
FROM products
WHERE title NOT IN ('bike', 'board', 'skis');

SELECT title,
       price,
       discount
FROM products
WHERE title IN ('bike', 'board', 'skis')
  AND price >= 30000;

SELECT title,
       price,
       discount
FROM products
WHERE price <= 30000
  AND price >= 15000; -- can be improved with BETWEEN

SELECT title,
       price,
       discount
FROM products
WHERE price BETWEEN 15000 AND 30000; -- improved version of above

SELECT title,
       price,
       discount
FROM products
WHERE price NOT BETWEEN 15000 AND 30000;

SELECT title,
       price,
       discount
FROM products
WHERE title LIKE 'b%'; -- LIKE: works with text, used with wildcards % and _
-- % any number of characters, even zero characters
-- _ only one character

SELECT title,
       price,
       discount
FROM products
WHERE title LIKE '%t%';
# NULL - can be in any column, with any variable types
# NULL - it's unknown what's stored there (not 0, not '', ...)

INSERT INTO products (title, price, discount)
VALUES (NULL, 45000, 0.9),
       ('', 35000, 0.9); -- NULL is different from empty line

SELECT *
FROM products;

SELECT *
FROM products
WHERE title IS NOT NULL; -- check for NULL