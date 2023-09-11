/*
 * General Tech. Homework #1
 * Viktor Uvarchev
 * 11 Sep 2023
 */

USE hr;

SELECT *
FROM employees;

SELECT *
FROM departments;

# 1) найти всех сотрудников c job_id = IT_PROG
SELECT first_name AS Name,
       last_name  AS Family_Name,
       job_id
FROM employees
WHERE job_id = 'IT_PROG';

# 2) найти сотрудников с зп больше 10 000
SELECT first_name AS Name,
       last_name  AS Family_Name,
       salary
FROM employees
WHERE salary > 10000;

# 3) найти сотрудников с зп от 10 000 до 20 000 (включая концы)
SELECT first_name AS Name,
       last_name  AS Family_Name,
       salary
FROM employees
WHERE salary BETWEEN 10000 AND 20000;

# 4) найти сотрудников не из 60, 30 и 100 департамента
SELECT first_name AS Name,
       last_name  AS Family_Name,
       department_id
FROM employees
WHERE department_id NOT IN (30, 60, 100)
   OR department_id IS NULL;

# 5) найти сотрудников, у которых фамилия кончается на a
SELECT first_name AS Name,
       last_name  AS Family_Name
FROM employees
WHERE last_name LIKE '%a';

# 6) вывести зарплату сотрудника с именем ‘Lex’ и фамилией ‘De Haan'
SELECT salary
FROM employees
WHERE first_name LIKE 'Lex'
AND last_name LIKE 'De Haan';

# 7) найти всех сотрудников, работающих в департаменте с id 90
SELECT first_name AS Name,
       last_name  AS Family_Name,
       department_id
FROM employees
WHERE department_id = 90;

# 8) найти все департаменты, у которых location_id 1700
SELECT *
FROM departments
WHERE location_id = 1700;