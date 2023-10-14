USE hr;

/*
Task 2 from Lesson 5 (subselect). print name, surname employees and department name where he works,
but deparment must be IT, Treasury, IT Support
*/

SELECT t1.first_name,
       t1.last_name,
       t2.department_name
FROM employees t1
         INNER JOIN departments t2
                    ON t1.department_id = t2.department_id
                        AND t2.department_name IN ('IT', 'Treasury', 'IT Support');


SELECT department_id
FROM departments
WHERE department_name IN ('IT', 'Treasury', 'IT Support'); -- result: 60, 120, 210

SELECT *
FROM employees t1
WHERE t1.department_id IN (60, 120, 210); -- > hard coded


SELECT t1.first_name,
       t1.last_name
FROM employees t1
WHERE t1.department_id
          IN (SELECT department_id -- subselect
              FROM departments
              WHERE department_name IN ('IT', 'Treasury', 'IT Support'));


SELECT t1.id,  -- access aliases of subselect
       t1.name -- access aliases of subselect
FROM (SELECT department_id   id,
             department_name name
      FROM departments
      WHERE department_name IN ('IT', 'Treasury', 'IT Support')) t1;


SELECT *
FROM employees;

SELECT *
FROM departments;

SELECT *
FROM locations;

/*
    Task 1. print departments name without any workers
*/
SELECT t1.department_name,
       t1.department_id,
       t2.employee_id
FROM departments t1
         LEFT JOIN employees t2 -- LEFT JOINT - to not loose null fields in table 'departments'
                   ON t1.department_id = t2.department_id
WHERE t2.employee_id IS NULL;


SELECT department_name,
       department_id
FROM departments
WHERE department_id
          NOT IN (SELECT DISTINCT department_id
                  FROM employees
                  WHERE department_id IS NOT NULL
          -- 'NOT IN' operator always returns false when any of the values in the list is 'null'
      );


/*
    Task 2. Print name, surname, salary for employees who works in cities 'Oxford', 'San Francisco'
*/
SELECT first_name,
       last_name,
       salary
FROM employees
WHERE department_id IN
      (SELECT department_id
       FROM departments
       WHERE location_id IN
             (SELECT location_id
              FROM locations
              WHERE city IN
                    ('Oxford', 'South San Francisco')));

SELECT t1.first_name,
       t1.last_name,
       t1.salary
FROM employees t1
         INNER JOIN departments t2
                    ON t1.department_id = t2.department_id
         INNER JOIN locations t3
                    ON t3.location_id = t2.location_id
WHERE city IN
      ('Oxford', 'South San Francisco');


-- ===================== --

USE shop;

SELECT *
FROM customers;

SELECT *
FROM sellers;

SELECT *
FROM orders;


/*
    Task 3. Print name all sellers and their boss
*/
SELECT t1.SNAME AS sellers,
       t2.SNAME AS bosses
FROM sellers t1
         LEFT JOIN sellers t2
                   ON t1.BOSS_ID = t2.SELL_ID;
