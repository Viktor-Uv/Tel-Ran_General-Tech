# Aggregate functions:

-- count(column_name) – count not null values
-- count(*) – all lines in result table

-- max(column_name) – max value in this column
-- min(column_name) – min value in this column
-- avg(column_name) – average value in this column
-- sum(column_name) – sum values in this column

USE hr;

SELECT MAX(salary)   AS max_salary,
       MIN(salary)   AS min_salary,
       AVG(salary)   AS avg_salary,
       SUM(salary)   AS sum_salary,
       COUNT(salary) AS count_employees
FROM employees;

SELECT COUNT(commission_pct) AS count_comission,
       COUNT(*)              AS count_employees
FROM employees;

/*
    print count employees without manager
 */
SELECT COUNT(*) AS count_empl_without_manager
FROM employees
WHERE manager_id IS NULL;

SELECT COUNT(manager_id) AS count_empl_with_manager,
       COUNT(*)          AS count_empl_without_manager
FROM employees;

/*
    print name, surname, salary employee(s) with max salary
 */
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary = (SELECT MAX(salary) AS max_salary
                FROM employees);

/*
    print average salary by company
 */
SELECT AVG(salary) average_salary
FROM employees;

/*
    print name, surname, salary of employees who get salary less than
    average by company
 */
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE salary < (SELECT AVG(salary)
                FROM employees);

/*
    print count of departments
 */
SELECT COUNT(*) AS departments_count
FROM departments;

/*
    print count of departments, where nobody works
 */
SELECT
#     t1.department_name,
#     t1.department_id,
#     t2.first_name,
#     t2.department_id
COUNT(*) AS department_count_without_workers
FROM departments t1
         LEFT JOIN employees t2
                   ON t1.department_id = t2.department_id
WHERE t2.department_id IS NULL;

SELECT COUNT(department_id) AS department_count_without_workers
FROM departments
WHERE department_id NOT IN (SELECT DISTINCT department_id
                            FROM employees
                            WHERE department_id IS NOT NULL);

/*
    print number of departments without duplicates
 */
SELECT COUNT(DISTINCT department_id)
FROM employees;

/*
    print average salary in department with id = 90
 */
SELECT AVG(salary)
FROM employees
WHERE department_id = 90;

/*
    print max salary in departments with id 70, 80
 */
SELECT MAX(salary)
FROM employees
WHERE department_id IN (70, 80);

/*
    print count employees from department_id=100 who earn more than 5000
 */
SELECT COUNT(*) AS count_employess
FROM employees
WHERE department_id = 100
  AND salary > 5000;
-- will reject any NULL values

/*
    print count employees from dep_id=60 who earn above average by company
 */
SELECT COUNT(*) AS count_employess
FROM employees
WHERE department_id = 60
  AND salary > (SELECT AVG(salary)
                FROM employees);


-- =============== --

# Grouping functions:

/*
    print count of employees in each department
 */
SELECT department_id,
       COUNT(*) AS employees_count
FROM employees
GROUP BY department_id;

/*
    print count of orders for each client (db shop)
 */
USE shop;

SELECT CUST_ID,
       COUNT(*) AS orders_count
FROM orders
GROUP BY CUST_ID;

/*
    print name, id and count of orders for each customer (db shop)
 */
SELECT t1.CNAME,
       t1.CUST_ID,
       t2.orders_count
FROM customers t1
         INNER JOIN (SELECT CUST_ID AS cid,
                            COUNT(*) orders_count
                     FROM orders
                     GROUP BY CUST_ID) t2
                ON t1.CUST_ID = t2.cid;
