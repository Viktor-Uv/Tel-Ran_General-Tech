/*
 * General Tech. Homework #8
 * Viktor Uvarchev
 * 03 Nov 2023
 */

USE hr;

SELECT *
FROM employees;

SELECT *
FROM departments;

# Найти сотрудников (вывести информацию о них - имя, фамилию),
#   у которых наибольшая зарплата в их конкретном департаменте

-- step 2: find all employees who have such salary and are from corresponding department
SELECT empl.first_name,
       empl.last_name,
       empl.salary,
       empl.department_id
FROM employees empl
         INNER JOIN (
    -- step 1: find max salary by departments
    SELECT department_id,
           MAX(salary) AS max_salary
    FROM employees
    GROUP BY department_id) salary_by_dep
                    ON salary_by_dep.department_id = empl.department_id
                        AND empl.salary = max_salary;

