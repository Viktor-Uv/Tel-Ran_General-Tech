/*
 * General Tech. Homework #7
 * Viktor Uvarchev
 * 25 Oct 2023
 */

SELECT *
FROM students;
SELECT *
FROM students2courses;

SELECT *
FROM customers;
SELECT *
FROM orders;
SELECT *
FROM sellers;


# Task 1. Используем БД uni
# Вывести имя студента и имена старост, которые есть на курсах, которые он проходит
USE uni;

SELECT students.name,
       headmen.name
FROM students
         INNER JOIN students2courses sc
                    ON students.id = sc.student_id
         INNER JOIN courses
                    ON sc.course_id = courses.id
         INNER JOIN students headmen
                    ON courses.headman_id = headmen.id;


# Task 2. Используем БД shop
# Выведите имена покупателей, которые сделали заказ.
# Предусмотрите в выборке также имена продавцов.
# Примечание: покупатели и продавцы должны быть из разных городов.
# В выборке должно присутствовать два атрибута — cname, sname.
USE shop;

SELECT customers.CNAME,
       sellers.SNAME
FROM customers
         INNER JOIN orders
                    ON customers.CUST_ID = orders.CUST_ID
         INNER JOIN sellers
                    ON orders.SELL_ID = sellers.SELL_ID
WHERE customers.CITY != sellers.CITY;


# Task 3. Используем БД shop
# Вывести имена покупателей которые ничего никогда не покупали.
# Решить задачу двумя способами : через join и через подзапрос
SELECT customers.CNAME
FROM customers
         LEFT JOIN orders
                   ON customers.CUST_ID = orders.CUST_ID
WHERE ORDER_ID IS NULL;

SELECT CNAME
FROM customers
WHERE CUST_ID NOT IN (SELECT CUST_ID
                      FROM orders);
