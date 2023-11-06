USE hr;

SELECT *
FROM employees;

/*
    Task one - print count of employees for each manager
 */
SELECT manager_id,
       COUNT(*) AS empl_count
FROM employees
GROUP BY manager_id;

/*
    Task two - print department name, count of employees for each department
 */
SELECT dep.department_name, /* to be able to SELECT 'department_name', it must be included in GROUP BY */
       COUNT(emp.employee_id) AS empl_count /* if we use count(*), all counts of NULL will appear as 1 */
FROM departments dep
         LEFT JOIN employees emp /* LEFT - to include departments without employees */
                   ON dep.department_id = emp.department_id
GROUP BY dep.department_id, dep.department_name; /* grouping by id, and including 'name' to use it in SELECT */

/*
    Task three - print max salary in each department (department_id, max salary)
 */
SELECT department_id,
       MAX(salary) AS max_salary
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id;

/*
    Task four - print manager name, surname and count of employees for each manager
 */
SELECT mng.first_name,
       mng.last_name,
       COUNT(emp.employee_id) AS employee_count
FROM employees mng
         INNER JOIN employees emp
                    ON mng.employee_id = emp.manager_id
GROUP BY mng.employee_id, mng.first_name, mng.last_name;

/*
    Task five - print name. surname for employees with max salary in their departments
 */
SELECT t1.last_name,
       t1.first_name,
       t2.department_id,
       t2.max_salary
FROM employees t1
         INNER JOIN (SELECT department_id,
                            MAX(salary) AS max_salary
                     FROM employees
                     GROUP BY department_id) t2
                    ON t1.salary = t2.max_salary AND t1.department_id = t2.department_id;


-- ============ --

-- HAVING - used as filter after GROUP BY


-- print all department_ids and max salaries where max_salary > 10000
SELECT department_id,
       MAX(salary) AS max_salary
FROM employees
GROUP BY department_id
HAVING MAX(salary) > 10000;

-- print all department_ids and max salaries where max_salary > 13000
-- and department_id > 50
SELECT department_id,
       MAX(salary) AS max_salary
FROM employees
WHERE department_id > 50 -- where works only for source rows
GROUP BY department_id
HAVING MAX(salary) > 13000
ORDER BY department_id;

SELECT manager_id,
       COUNT(*) AS employees_count
FROM employees
GROUP BY manager_id
HAVING COUNT(*) > 5;

/*
    Task six - print department name where count of employees > 10
 */
-- subtask - group departments by employees_count and filter by employee_count > 10
SELECT department_id,
       COUNT(employee_id) AS employee_count
FROM employees
GROUP BY department_id
HAVING COUNT(employee_id) > 10;

-- option 1, with JOIN
SELECT t1.department_name,
       t2.department_id,
       t2.employee_count
FROM departments t1
         INNER JOIN (SELECT department_id,
                            COUNT(employee_id) AS employee_count
                     FROM employees
                     GROUP BY department_id
                     HAVING COUNT(employee_id) > 10) t2
                    ON t1.department_id = t2.department_id;

-- option 2, with SUBSELECT
SELECT department_name
FROM departments
WHERE department_id IN (SELECT department_id
                        FROM employees
                        GROUP BY department_id
                        HAVING COUNT(*) > 10);

/*
    Task seven - print department name where count of employee more than average
 */
-- subtask 4: final result
SELECT department_name
FROM departments
WHERE department_id IN (
    -- subtask 3: find department id where employee count is above average
    SELECT department_id
    FROM employees
    GROUP BY department_id
    HAVING COUNT(*) > (
        -- subtask 2: find average employee count
        SELECT AVG(employee_count)
        FROM (
                 -- subtask 1: find employee count by departments
                 SELECT department_id,
                        COUNT(employee_id) AS employee_count
                 FROM employees
                 GROUP BY department_id) t1));

/*
    SQL KEYWORD ORDER:
        SELECT
        FROM
        WHERE
        GROUP BY
        HAVING
        ORDER BY
 */
