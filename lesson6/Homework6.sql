/*
 * General Tech. Homework #6
 * Viktor Uvarchev
 * 20 Oct 2023
 */

USE shop;
SELECT *
FROM customers;
SELECT *
FROM orders;
SELECT *
FROM sellers;

# Task 1. Выведите имена покупателей, которые совершили покупку на сумму больше 1000 условных единиц.
# В выборке должно присутствовать два атрибута — cname, amt.
SELECT t1.cname,
       t2.amt
FROM customers t1
         INNER JOIN orders t2
                    ON t1.cust_id = t2.cust_id
                        AND t2.amt > 1000;

# Task 2. Выведите имена покупателей, которые совершили покупку на сумму больше 1000 условных единиц.
# В выборке должно присутствовать два атрибута — cname, amt.
-- same as in Task 1

# Task 3.Для каждого сотрудника выведите разницу между комиссионными его босса и его собственными.
# Если у сотрудника босса нет, выведите NULL.
# Вывести: sname, difference.
SELECT sell.sname            AS sname,
       boss.comm - sell.comm AS difference
FROM sellers sell
         LEFT JOIN sellers boss
                   ON boss.sell_id = sell.boss_id;

# Task 4.Выведите пары покупателей и обслуживших их продавцов из одного города.
# Вывести: sname, cname, city
SELECT sell.sname AS sname,
       cust.cname AS cname,
       sell.city  AS city
FROM sellers sell
         INNER JOIN orders ordr
                    ON sell.sell_id = ordr.sell_id
         INNER JOIN customers cust
                    ON cust.cust_id = ordr.cust_id
                        AND sell.city = cust.city;
