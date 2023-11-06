/*
 * General Tech. Homework #9
 * Viktor Uvarchev
 * 06 Nov 2023
 */

USE hr;

# Найти департамент с наибольшим количеством сотрудников(вывести название департамента и ид департамента)

-- subtask 4: final result
SELECT department_id,
       department_name
FROM departments
WHERE department_id IN (
    -- subtask 3: select department_id with maximum number of employees
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING COUNT(employee_id) = (
        -- subtask 2: maximum quantity of employees
        SELECT MAX(employee_count) AS max_empl_count
        FROM (
                 -- subtask 1: departments grouped by employee_count
                 SELECT department_id,
                        COUNT(employee_id) AS employee_count
                 FROM employees
                 GROUP BY department_id) departments_grouped_by_empl_count));
