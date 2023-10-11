/*
 * General Tech. Homework #5
 * Viktor Uvarchev
 * 11 Oct 2023
 */

USE hr;

SELECT *
FROM employees;

SELECT *
FROM departments;

SELECT *
FROM locations;

SELECT *
FROM jobs;

# 1.Вывести job_id тех сотрудников, которые зарабатывают больше своего менеджера (прием SELF join)
SELECT t1.job_id
FROM employees t1
         INNER JOIN employees t2
                    ON t1.manager_id = t2.employee_id
WHERE t1.salary > t2.salary;

# 2.Вывести имя, фамилию и город сотрудников, которые работают в Seattle или Toronto (участвуют три таблицы)
SELECT t1.first_name,
       t1.last_name,
       t3.city
FROM employees t1
         INNER JOIN departments t2
                    ON t1.department_id = t2.department_id
         INNER JOIN locations t3
                    ON t2.location_id = t3.location_id
WHERE t3.city IN ('Seattle', 'Toronto');

# 3.Вывести имя, фамилию, название департамента и название должности сотрудника (участвуют три таблицы)
SELECT t1.first_name,
       t1.last_name,
       t2.department_name,
       t3.job_title
FROM employees t1
         INNER JOIN departments t2
                    ON t1.department_id = t2.department_id
         INNER JOIN jobs t3
ON t1.job_id = t3.job_id;
